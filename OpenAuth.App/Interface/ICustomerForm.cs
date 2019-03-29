using System;
using System.Collections.Generic;
using System.Text;

namespace OpenAuth.App.Interface
{
    public interface  ICustomerForm
    {
        void Add(string flowInstanceId, string frmData);
    }
}
