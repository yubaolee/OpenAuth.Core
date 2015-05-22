using System;

namespace OpenAuth.Domain.Utility
{
    public class ValueObjectIsInvalidException : Exception
    {
        public ValueObjectIsInvalidException(string message)
            : base(message)
        {

        }
    }
}