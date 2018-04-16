using System;

namespace GDTLibrary
{
    /// <summary>
    /// Classe utilizada para popular o DataTable de obras no SGDT00002.aspx
    /// </summary>
    public class Contrato
    {
        // Histórico de Alterações
        // Nº Alt.  Data        Pessoa            Chamado  Descrição
        // ------- ----------- ------------------ -------- -----------------------------------------------------------------------------------------------
        // 00      11/04/2018  Adriano Tomczak     #20265   -Criação da Classe. 
        //
        
        public string Empresa { get; set; }
        public string NumeroContrato { get; set; }
        public string GeracaoContrato { get; set; }
        public string Gnf { get; set; }
        public string Os { get; set; }
        public string Cliente { get; set; }
        public string LocalObra { get; set; }
        public string InicioObra { get; set; }
        public string EntregaObra { get; set; }
        public string Supervisor { get; set; }
    }
}
