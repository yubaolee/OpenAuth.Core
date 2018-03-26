using OpenAuth.Repository.Domain;

namespace OpenAuth.App.Response
{
    public class FlowVerificationResp :FlowInstance
    {
        public string FrmDataHtml
        {
            get { return FormUtil.Preview(FrmContentData, FrmContentParse, FrmData); }
        }
    }
}
