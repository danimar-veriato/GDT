using System;

namespace GDTLibrary
{
    /// <summary>
    /// Classe utilizada para popular o DataTable do GDT00003.aspx
    /// </summary>
    public class TerceiroList
    {
        public string EmprCodigo { get; set; }
        public Int32 DpesCodigo { get; set; }
        public string RazaoSocial { get; set; }
        public string Situacao { get; set; }
        public string DtVencAlvara { get; set; }
        public string DtVencCndFederal { get; set; }
        public string DtVencCndMunicipal { get; set; }
    }
}
