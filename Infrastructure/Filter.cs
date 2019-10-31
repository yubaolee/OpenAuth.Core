namespace Infrastructure
{
   
    public class Filter
    {
        public string Key { get; set; }
        public string Value { get; set; }
        public string Contrast { get; set; }
        
        public string Text { get; set; }
    }

    public class FilterGroup 
    {
        /// <summary>
        /// or /and
        /// </summary>
        public string Operation { get; set; }
        public Filter[] Filters { get; set; }
        public FilterGroup[] Children { get; set; }
    }
    
    
    
}