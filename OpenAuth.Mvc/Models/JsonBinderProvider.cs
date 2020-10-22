using System;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.ModelBinding.Binders;
using Newtonsoft.Json.Linq;
using OpenAuth.Mvc.Models;

namespace OpenAuth.Mvc
{
    public class JsonBinderProvider : IModelBinderProvider
    {
        public IModelBinder GetBinder(ModelBinderProviderContext context)
        {
            if(context == null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            if (context.Metadata.ModelType == typeof(JObject))
            {
                return new BinderTypeModelBinder(typeof(JobjectModelBinder));
            }

            return null;
        }
    }
}