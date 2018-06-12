using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PgSim.Models
{
    public class formtorequest
    {
        public string appId { get; set; }
        public string orderId { get; set; }
        public string orderAmount { get; set; }
        public string orderCurrency { get; set; }
        public string orderNote { get; set; }
        public string customerName { get; set; }
        public string customerEmail { get; set; }
        public string customerPhone { get; set; }
        public string notifyUrl { get; set; }
        public string returnUrl { get; set; }
    }
}
