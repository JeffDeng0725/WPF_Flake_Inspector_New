using MyToDo1.Common.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyToDo1.Common.Models
{
    public class ToDoDto : BaseDto
    {
        private string title;
        private string content;
        private int status;
        private string target;
        private string dtoPath;

        public string Title
        {
            get { return title; }
            set { title = value; }
        }
        public string Content
        {
            get { return content; }
            set { content = value; }
        }
        public int Status
        {
            get { return status; }
            set { status = value; }
        }
        public string Target
        {
            get { return target; }
            set { target = value; }
        }
        public string DtoPath
        {
            get { return dtoPath; }
            set { dtoPath = value; }
        }
    }
}
