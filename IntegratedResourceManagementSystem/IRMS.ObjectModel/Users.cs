using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using BLToolkit.Mapping;
using BLToolkit.Common;
using BLToolkit.DataAccess;

namespace IRMS.ObjectModel
{
    [TableName("USERS")]
    public class UsersClass
    {
        [MapField("ID"), PrimaryKey, NonUpdatable]
        public long ID
        { get; set; }

        [MapField("USERNAME")]
        public string Username
        { get; set; }

        [MapField("PASSWORD")]
        public string UserPass
        { get; set; }

        [MapField("DEPTID")]
        public int DeptID
        { get; set; }

        [MapField("USERLEVELID")]
        public int UserLevelID
        { get; set; }

        [MapField("FULLNAME")]
        public string FullName
        { get; set; }

        [MapField("EMAIL")]
        public string Email
        { get; set; }
    }
}
