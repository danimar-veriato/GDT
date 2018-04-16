//Exportar tabela para excel
/*
    exemplo de uso:
    1 - Crie um botão com um ID qualquer ID="idDoBotao" 
        <a id="destroyTable" rel="tooltip" data-placement="bottom" title="Exportar tabela para Excel" class="btn"><i class="icon-download-alt"></i></a>

    2 - crie um método para capturar o clique neste botão
                $('#idDoBotao').on('click', function () {               CLIQUE DO BOTÃO
                    var oTable = $('#tabela').dataTable();              GUARDA TABELA EM UMA VARIÁVEL           (OPCIONAL)
                    oTable.fnDestroy();                                 DESMONTA DATATABLE                      (OPCIONAL)
                    $('thead').prependTo($('#tabela'));                 CORRIGE POSIÇÃO THEAD E TBODY           (OPCIONAL)
                    tableToExcel('idDaTabela', 'NomeDaAbaDoExcel');     CHAMA MÉTODO QUE FAZ O DOWNLOAD EM XLS
                    montaDataTableDomSge();                             REMONTA TABELA DATATABLE                (OPCIONAL)
                });

    EXEMPLO DETALHADO EM CRMN1183 - Importante lembrar que a montagem do dataTable deve ser feita em um método para 
                                    possa ser chamado a qualquer momento e não repetir código.
*/
var tableToExcel = (function () {
    var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>'
    , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
    return function (table, name) {
        if (!table.nodeType) table = document.getElementById(table)
        var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }
        window.location.href = uri + base64(format(template, ctx));
    }
})()

// Apenas para auxilio, pode-se informar a cor que desejar.
// Cor para msg de sucesso: rgba(58, 160, 52, 0.8)
// Cor para msg de alerta (não erro): rgba(197, 105, 16, 0.8)
// Exemplo de chamada do c#:
//  ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertDomsge('SUCESSO!','Oportunidade alterada com sucesso.', 'rgba(58, 160, 52, 0.8)')", true);
function alertDomsge(titulo, texto, color) {
    $.gritter.add({
        position: 'top-right',
        title: titulo,
        text: texto,
        time: 5000
    });

    $('.gritter-item').css("background-color", color);
}


// Exemplo de chamada do c#:
// instaciar a classe ACEL0310 para utilizar o método que retira caracteres identificados com problemas para o javascript.
// caso um novo caractere seja encontrado, que gere erro na exibição do js pode ser acrecido na expressão regular na classe indicada.
// ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowValidation", "javascript:alertErroDomsge('Alerta','" + ACEL0310.trataMensagemErro(exc.Message) + "')", true);

function alertErroDomsge(titulo, texto) {
    $('#lblTituloErro').empty();
    $('#lblTituloErro').append(titulo);
    $('#lblMsgErro').empty();
    $('#lblMsgErro').append(texto);
    $('#modal-error-sge').modal('show');
}


