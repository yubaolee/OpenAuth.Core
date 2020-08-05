using Infrastructure.Const;

namespace Infrastructure.Utilities
{
    public class WebResponseContent : Response
    {
        public WebResponseContent()
        {
            Code = 200;
            Message = "操作成功";
        }
        public WebResponseContent(bool status)
        {
            this.Status = status;
        }
        public bool Status { get; set; }
        public object Result { get; set; }

        public WebResponseContent OK()
        {
            this.Status = true;
            return this;
        }

        public static WebResponseContent Instance
        {
            get { return new WebResponseContent(); }
        }
        public WebResponseContent OK(string message = null,object data=null)
        {
            this.Status = true;
            this.Message = message;
            this.Result = data;
            return this;
        }
        public WebResponseContent OK(ResponseType responseType)
        {
            return Set(responseType, true);
        }
        public WebResponseContent Error(string message = null)
        {
            this.Status = false;
            this.Message = message;
            return this;
        }
        public WebResponseContent Error(ResponseType responseType)
        {
            return Set(responseType, false);
        }
        public WebResponseContent Set(ResponseType responseType)
        {
            bool? b = null;
            return this.Set(responseType, b);
        }
        public WebResponseContent Set(ResponseType responseType, bool? status)
        {
            return this.Set(responseType, null, status);
        }
        public WebResponseContent Set(ResponseType responseType, string msg)
        {
            bool? b = null;
            return this.Set(responseType, msg, b);
        }
        public WebResponseContent Set(ResponseType responseType, string msg, bool? status)
        {
            if (status != null)
            {
                this.Status = (bool)status;
            }
            this.Code = (int)responseType;
            if (!string.IsNullOrEmpty(msg))
            {
                Message = msg;
                return this;
            }
            Message = responseType.GetMsg();
            return this;
        }

    }
}
