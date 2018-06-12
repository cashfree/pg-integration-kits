using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PgSim.Models;

namespace PgSim.Controllers
{
    public class pgcontroller : Controller
    {
        public IActionResult Index()
        {
            ViewData["Title"] = "Cashfree-PG TestForm";
            return View();
        }

        [HttpPost]
        public IActionResult HandleRequest(formtorequest model)
        {

            string secretKey = "ENTER_YOUR_SECRET_KEY";
            string mode = "TEST";  //change mode to PROD for production
            string signatureData = "";
            PropertyInfo[] keys = model.GetType().GetProperties();
            keys =keys.OrderBy(key => key.Name).ToArray();

            foreach (PropertyInfo key in keys)
            {
                signatureData += key.Name + key.GetValue(model);
            }
            var hmacsha256 = new HMACSHA256(StringEncode(secretKey));
            byte[] gensignature = hmacsha256.ComputeHash(StringEncode(signatureData));
            string signature = Convert.ToBase64String(gensignature);
            ViewData["signature"] = signature;
            if(mode == "PROD")
            {
                ViewData["url"] = "https://www.cashfree.com/checkout/post/submit";
            }else{
                ViewData["url"] = "https://test.cashfree.com/billpay/checkout/post/submit";
            }
            return View(model);
        }

        [HttpPost]
        public IActionResult HandleResponse(IFormCollection form)
        {
            string secretKey = "ENTER_YOUR_SECRET_KEY";
            string orderId = Request.Form["orderId"];
            string orderAmount = Request.Form["orderAmount"];
            string referenceId = Request.Form["referenceId"];
            string txStatus = Request.Form["txStatus"];
            string paymentMode = Request.Form["paymentMode"];
            string txMsg = Request.Form["txMsg"];
            string txTime = Request.Form["txTime"];
            string signature = Request.Form["signature"];

            string signatureData = orderId + orderAmount + referenceId + txStatus + paymentMode + txMsg + txTime;

            var hmacsha256 = new HMACSHA256(StringEncode(secretKey));
            byte[] gensignature = hmacsha256.ComputeHash(StringEncode(signatureData));
            string computedsignature = Convert.ToBase64String(gensignature);
            if(signature == computedsignature)
            {
                ViewData["panel"] = "panel panel-success";
                ViewData["heading"] = "Signature Verification Successful";

            }
            else
            {
                ViewData["panel"] = "panel panel-danger";
                ViewData["heading"] = "Signature Verification Failed";

            }
            ViewData["orderId"] = orderId;
            ViewData["orderAmount"] = orderAmount;
            ViewData["referenceId"] = referenceId;
            ViewData["txStatus"] = txStatus;
            ViewData["txMsg"] = txMsg;
            ViewData["txTime"] = txTime;
            ViewData["paymentMode"] = paymentMode;
            return View();
        }

        private static byte[] StringEncode(string text)
        {
            var encoding = new UTF8Encoding();
            return encoding.GetBytes(text);
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = System.Diagnostics.Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
