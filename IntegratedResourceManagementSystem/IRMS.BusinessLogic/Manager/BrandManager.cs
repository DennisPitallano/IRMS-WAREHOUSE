using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.BusinessLogic.DataAccess;
using IRMS.ObjectModel;
using BLToolkit.Data;

namespace IRMS.BusinessLogic.Manager
{
    public class BrandManager
    {
        #region Accessor
        BrandAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return BrandAccessor.CreateInstance(); }
        }
        #endregion

        public Brand GetBrandByKey(long id)
        {
            return Accessor.Query.SelectByKey<Brand>(id) ?? new Brand();
        }

        public List<Brand> Brands()
        {
            return Accessor.Brands();
        }

        public void Save(Brand brand)
        {
            using (DbManager db = new DbManager())
            {
                if (brand.RecordNo != 0)
                {
                    Accessor.Query.Update(db, brand);
                }
                else
                {
                    Accessor.Query.Insert(db, brand);
                }
            }
        }

        public void Delete(Brand brand)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, brand);
            }
        }

        public List<Brand> SearchBrands(string[] search_parameter)
        {
            string[] columns = new string[2];
            columns[0] = "BRAND_CODE";
            columns[1] = "BRAND_DESCRIPTION";
            return Accessor.Query.SelectByKeyWords<Brand>(search_parameter, columns);
        }
    }
}
