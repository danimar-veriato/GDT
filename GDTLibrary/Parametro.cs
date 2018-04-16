using Dominio.DOMDB;
using System;
using System.Data;
using System.Text;


namespace GDTLibrary
{
    /// <summary>
    /// Classe para manunteção de parâmetros do sistema GDT
    /// </summary>
    public class Parametro
    {
        // Histórico de Alterações
        // Nº Alt.  Data        Pessoa            Chamado  Descrição
        // ------- ----------- ------------------ -------- -----------------------------------------------------------------------------------------------
        // 00      04/04/2018  Adriano Tomczak     #20265   -Criação da Classe. 
        //

        /// <summary>
        /// Contrutor da classe
        /// </summary>
        /// <param name="empresa">Empresa para manutenção e consulta dos parâmetros</param>
        public Parametro(string empresa)
        {
            Empresa = empresa;
        }

        StringBuilder Query = new StringBuilder();
        DatabaseOracle dbOracle = new DatabaseOracle();

        #region atributos
        public string Empresa { get; set; }
        public int ValidadeSep { get; set; }
        public int ValidadeNr10 { get; set; }
        public int ValidadeNr12 { get; set; }
        public int ValidadeNr18 { get; set; }
        public int ValidadeNr33 { get; set; }
        public int ValidadeNr35 { get; set; }

        #endregion atributos

        #region metodos
        /// <summary>
        /// Retorna os parâmetros da empresa
        /// </summary>
        /// <returns>Retorna um DataSet com os parâmetros</returns>
        public DataSet listaParametros()
        {
            try
            {
                Query.Remove(0, Query.Length);
                if (!String.IsNullOrEmpty(Empresa))
                {
                    Query.Append(" SELECT empr_codigo, ");
                    Query.Append("        validade_anos_sep, ");
                    Query.Append("        validade_anos_nr_10, ");
                    Query.Append("        validade_anos_nr_12, ");
                    Query.Append("        validade_anos_nr_18, ");
                    Query.Append("        validade_anos_nr_33, ");
                    Query.Append("        validade_anos_nr_35 ");                    
                    Query.Append("   FROM gdt_parametros ");
                    Query.Append("  WHERE empr_codigo = '" + Empresa + "' ");

                    DataSet ds = dbOracle.Lista("gdt_parametros", Query.ToString());
                    return ds;
                }
                return null;
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }

        }

        public void gravaParametro(string tipoOperacao)
        {
            try
            {
                if (tipoOperacao.Equals("I"))
                {
                    Query.Remove(0, Query.Length);
                    Query.Append("INSERT into gdt_parametros ( ");
                    Query.Append("       empr_codigo, ");
                    Query.Append("       validade_anos_sep, ");
                    Query.Append("       validade_anos_nr_10, ");
                    Query.Append("       validade_anos_nr_12,");
                    Query.Append("       validade_anos_nr_18,");
                    Query.Append("       validade_anos_nr_33, ");
                    Query.Append("       validade_anos_nr_35) ");                    
                    Query.Append(" VALUES ( ");
                    Query.Append(" '" + Empresa + "', ");
                    Query.Append("" + ValidadeSep + ", ");
                    Query.Append("" + ValidadeNr10 + ", ");
                    Query.Append("" + ValidadeNr12 + ", ");
                    Query.Append("" + ValidadeNr18 + ", ");
                    Query.Append("" + ValidadeNr33 + ", ");
                    Query.Append("" + ValidadeNr35 + " ");                    
                    Query.Append(" ) ");

                    dbOracle.InUp("gdt_parametros", Query.ToString(), "ACESSOS", "I");
                }
                else
                {
                    Query.Remove(0, Query.Length);
                    Query.Append("UPDATE gdt_parametros SET ");
                    Query.Append("       empr_codigo = '" + Empresa + "', ");
                    Query.Append("       validade_anos_sep = " + ValidadeSep + ", ");
                    Query.Append("       validade_anos_nr_10 = " + ValidadeNr10 + ", ");
                    Query.Append("       validade_anos_nr_12 = " + ValidadeNr12 + ", ");
                    Query.Append("       validade_anos_nr_18 = " + ValidadeNr18 + ", ");
                    Query.Append("       validade_anos_nr_33 = " + ValidadeNr33 + ", ");
                    Query.Append("       validade_anos_nr_35 = " + ValidadeNr35 + " ");                                      
                    Query.Append(" WHERE empr_codigo = '" + Empresa + "' ");

                    dbOracle.InUp("gdt_parametros", Query.ToString(), "ACESSOS", "U");
                }
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }
        }
        #endregion metodos


    }
}
