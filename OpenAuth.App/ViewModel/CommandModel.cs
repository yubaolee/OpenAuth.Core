// ***********************************************************************
// Assembly         : OpenAuth.App
// Author           : yubaolee
// Created          : 09-05-2016
//
// Last Modified By : yubaolee
// Last Modified On : 09-05-2016
// Contact : Microsoft
// File: CommandModel.cs
// ***********************************************************************

using OptimaJet.Workflow.Core.Model;

namespace OpenAuth.App.ViewModel
{
    /// <summary>
    /// workflow命令
    /// </summary>
    public class CommandModel
    {
        public string Key { get; set; }
        public string Value { get; set; }
        public TransitionClassifier Classifier { get; set; }
    }
}