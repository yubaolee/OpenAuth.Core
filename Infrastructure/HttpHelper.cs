// ***********************************************************************
// Assembly         : Infrastructure
// Author           : yubaolee
// Created          : 06-21-2016
//
// Last Modified By : yubaolee
// Last Modified On : 06-21-2016
// Contact : 
// File: HttpHelper.cs
// ***********************************************************************

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;

namespace Infrastructure
{
    /// <summary>
    /// WebApi请求帮助类
    /// </summary>
    public class HttpHelper
    {
        private readonly HttpClient _httpClient;
        private readonly string _baseUriAddress;

        #region 构造

        /// <summary>
        /// </summary>
        /// <param name="baseAddress">请求的基地址</param>
        public HttpHelper(string baseAddress = "")
        {
            if (string.IsNullOrEmpty(baseAddress))
            {
                this._baseUriAddress = ConfigurationManager.AppSettings["CommonApiUriString"];
            }
            else
            {
                this._baseUriAddress = baseAddress;
            }
            _httpClient = new HttpClient {BaseAddress = new Uri(_baseUriAddress)};


        }

        /// <summary>
        /// 创建带用户信息的请求客户端 
        /// </summary>
        /// <param name="userName">用户账号</param>
        /// <param name="pwd">用户密码，当WebApi端不要求密码验证时，可传空串</param>
        /// <param name="baseAddress">The URI string.</param>
        public HttpHelper(string userName, string pwd = "", string baseAddress = "")
            : this(baseAddress)
        {
            if (!string.IsNullOrEmpty(userName))
            {
                _httpClient.DefaultRequestHeaders.Authorization = CreateBasicCredentials(userName, pwd);

            }
        }

        #endregion

        public string Post(string requestUrl)
        {
            var result = _httpClient.PostAsync(requestUrl, new StringContent(""));
            return result.Result.Content.ReadAsStringAsync().Result;
        }


        /// <summary>
        /// Post数据 返回string类型
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="entity">实体</param>
        /// <param name="requestUri">例如/api/Files/UploadFile</param>
        /// <returns></returns>
        public string Post<T>(T entity, string requestUri)
        {
            HttpResponseMessage respsonse = RequestPost(entity, requestUri);           
            return respsonse.Content.ReadAsStringAsync().Result;
        }
        /// <summary>
        /// Post数据 返回byte[]类型 用于批量下载的时候请求接口就直接返回文件字节以供下载
        /// </summary>
        /// <returns></returns>
        public byte[] PostGetByte<T>(T entity, string requestUri)
        {
            HttpResponseMessage respsonse = RequestPost(entity, requestUri);
            return respsonse.Content.ReadAsByteArrayAsync().Result;
        }

        /// <summary>
        /// 以Post方式请求数据 返回HttpResponseMessage 
        /// </summary>
        /// <typeparam name="T">请求传入的对象类型</typeparam>
        /// <param name="entity">请求传入的对象</param>
        /// <param name="requestUri">请求地址</param>
        /// <returns></returns>
        private HttpResponseMessage RequestPost<T>(T entity, string requestUri)
        {
            string request = string.Empty;
            if (entity != null)
                request = JsonHelper.Instance.Serialize(entity);
            HttpContent httpContent = new StringContent(request);
            httpContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            requestUri = string.Concat(_baseUriAddress, requestUri);
            var result = _httpClient.PostAsync(requestUri, httpContent);
            return result.Result;
        }

        /// <summary>
        /// Get请求数据
        /// <para>yubaolee 2016-3-3 重构与post同样异步调用</para>
        /// </summary>
        /// <param name="parameters">参数字典</param>
        /// <param name="requestUri">例如/api/Files/UploadFile</param>
        /// <returns></returns>
        public string Get(Dictionary<string, string> parameters, string requestUri)
        {
            string strParam = String.Empty;
            if (parameters != null)
            {
                strParam = string.Join("&", parameters.Select(o => o.Key + "=" + o.Value));
                requestUri = string.Concat(_baseUriAddress, requestUri, '?', strParam);
            }
            else
            {
                requestUri = string.Concat(_baseUriAddress, requestUri);
            }

            using (HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, requestUri))
            {
                return _httpClient.SendAsync(request).Result.Content.ReadAsStringAsync().Result;

            }


        }
        /// <summary>
        /// 发送一个没有参数的HTTP请求
        /// <para>yubaolee 2016-3-3 重构引用现有的get方法</para>
        /// </summary>
        /// <param name="requestUri">The request URI.</param>
        /// <returns>System.String.</returns>
        public string Get(string requestUri)
        {
            return Get(null, requestUri);
        }
        /// <summary>
        /// Get请求数据
        /// </summary>
        /// <param name="parameters">参数字典</param>
        /// <param name="requestUri">例如/api/Files/UploadFile</param>
        /// <returns>实体对象</returns>
        public T Get<T>(Dictionary<string, string> parameters, string requestUri) where T : class
        {
            string jsonString = Get(parameters, requestUri);
            if (string.IsNullOrEmpty(jsonString))
                return null;

            return JsonHelper.Instance.Deserialize<T>(jsonString);
        }

        private AuthenticationHeaderValue CreateBasicCredentials(string userName, string password)
        {
            string toEncode = userName + ":" + password;
            // The current HTTP specification says characters here are ISO-8859-1.
            // However, the draft specification for the next version of HTTP indicates this encoding is infrequently
            // used in practice and defines behavior only for ASCII.
            Encoding encoding = Encoding.GetEncoding("utf-8");
            byte[] toBase64 = encoding.GetBytes(toEncode);
            string parameter = Convert.ToBase64String(toBase64);

            return new AuthenticationHeaderValue("Basic", parameter);
        }
    }
}
