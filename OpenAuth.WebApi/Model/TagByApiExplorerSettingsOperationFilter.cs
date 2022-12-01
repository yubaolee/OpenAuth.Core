﻿using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace OpenAuth.WebApi.Model
{
    public class TagByApiExplorerSettingsOperationFilter : IOperationFilter
    {
        public void Apply(OpenApiOperation operation, OperationFilterContext context)
        {
            if (context.ApiDescription.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor)
            {
                var apiExplorerSettings = controllerActionDescriptor
                    .ControllerTypeInfo.GetCustomAttributes(typeof(ApiExplorerSettingsAttribute), true)
                    .Cast<ApiExplorerSettingsAttribute>().FirstOrDefault();
                if (apiExplorerSettings != null && !string.IsNullOrWhiteSpace(apiExplorerSettings.GroupName))
                {
                    operation.Tags = new List<OpenApiTag> { new OpenApiTag { Name = apiExplorerSettings.GroupName } };
                }
                else
                {
                    operation.Tags = new List<OpenApiTag>
                        {new OpenApiTag {Name = controllerActionDescriptor.ControllerName}};
                }
            }
        }
    }
}