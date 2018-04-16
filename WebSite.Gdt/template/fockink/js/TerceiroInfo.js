/* Arquivo concentrador de códigos JS/Jquery do Terceiro - Info Gerais
*
*  Histórico de Alterações
*  Nº Alt.  Data        Pessoa            Chamado  Descrição
*  ------- ----------- ------------------ -------- -----------------------------------------------------------------------------------------------
*  000     10/04/2018  Adriano Tomczak    #20265   -Criação do arquivo. 
*  001
*  002
*
*/
//tratamento do radio isento CND Estadual
$(document).on('change', "[name$='rbIsentoCNDEstadual']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencCndEstadual]").attr('disabled', true);
        $("[id$=txtVencCndEstadual]").val("");
        $('span.vencCndEst').hide();
    } else {
        $("[id$=txtVencCndEstadual]").removeAttr('disabled');
        $('span.vencCndEst').show();
    }
});
function gerenciaIsentoCNDEstadual() {
    if ($("[id$=rbIsentoCNDEstadual] input:checked").val() == "N") {
        $("[id$=txtVencCndEstadual]").removeAttr('disabled');
        $('span.vencCndEst').show();
    } else {
        $("[id$=txtVencCndEstadual]").attr('disabled', true);
        $('span.vencCndEst').hide();
    }
}
//tratamento do radio isento FGTS
$(document).on('change', "[name$='rbIsentoFGTS']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencFGTS]").attr('disabled', true);
        $("[id$=txtVencFGTS]").val("");
        $('span.vencFGTS').hide();
    } else {
        $("[id$=txtVencFGTS]").removeAttr('disabled');
        $('span.vencFGTS').show();
    }
});
function gerenciaIsentoFgts() {
    if ($("[id$=rbIsentoFGTS] input:checked").val() == "N") {
        $("[id$=txtVencFGTS]").removeAttr('disabled');
        $('span.vencFGTS').show();
    } else {
        $("[id$=txtVencFGTS]").attr('disabled', true);
        $('span.vencFGTS').hide();
    }
}
//tratamento do radio isento PPRA
$(document).on('change', "[name$='rbIsentoPPRA']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPPRA]").attr('disabled', true);
        $("[id$=txtVencPPRA]").val("");
        $('span.vencPPRA').hide();
    } else {
        $("[id$=txtVencPPRA]").removeAttr('disabled');
        $('span.vencPPRA').show();
    }
});
function gerenciaIsentoPpra() {
    if ($("[id$=rbIsentoPPRA] input:checked").val() == "N") {
        $("[id$=txtVencPPRA]").removeAttr('disabled');
        $('span.vencPPRA').show();
    } else {
        $("[id$=txtVencPPRA]").attr('disabled', true);
        $('span.vencPPRA').hide();
    }
}

//tratamento do radio isento PCMSO
$(document).on('change', "[name$='rbIsentoPCMSO']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPCMSO]").attr('disabled', true);
        $("[id$=txtVencPCMSO]").val("");
        $(".examePCMSO").hide();
        limpaExamesPrevistosPCMSO();
        $('span.vencPCMSO').hide();
    } else {
        $("[id$=txtVencPCMSO]").removeAttr('disabled');
        $(".examePCMSO").show();
        $('span.vencPCMSO').show();
    }
});

function gerenciaIsentoPCMSO() {
    if ($("[id$=rbIsentoPCMSO] input:checked").val() == "N") {
        $("[id$=txtVencPCMSO]").removeAttr('disabled');
        $(".examePCMSO").show();
        $('span.vencPCMSO').show();
    } else {
        $("[id$=txtVencPCMSO]").attr('disabled', true);
        $(".examePCMSO").hide();
        limpaExamesPrevistosPCMSO();
        $('span.vencPCMSO').hide();
    }
}

function limpaExamesPrevistosPCMSO() {
    $("[id$=chkAsoTerc]").prop("checked", false);
    $("[id$=chkAvalOftalTerc]").prop("checked", false);
    $("[id$=chkAudiometriaTerc]").prop("checked", false);
    $("[id$=chkAcuidadeVisualTerc]").prop("checked", false);
    $("[id$=chkAvalPsicoTerc]").prop("checked", false);
    $("[id$=chkEletroCardiogramaTerc]").prop("checked", false);
    $("[id$=chkEletroEncefalogramaTerc]").prop("checked", false);
    $("[id$=chkEspirometriaTerc]").prop("checked", false);
    $("[id$=chkRXLomboSacraTerc]").prop("checked", false);
    $("[id$=chkRXToraxTerc]").prop("checked", false);
    $("[id$=chkHemogramaTerc]").prop("checked", false);
    $("[id$=chkPlaquetasTerc]").prop("checked", false);
    $("[id$=chkTipoSanguineoTerc]").prop("checked", false);
    $("[id$=chkGlicemiaTerc]").prop("checked", false);
    $("[id$=chkGamaGtTerc]").prop("checked", false);
    $("[id$=chkColesterolTerc]").prop("checked", false);
    $("[id$=chkTgoTerc]").prop("checked", false);
    $("[id$=chkTgpTerc]").prop("checked", false);
    $("[id$=chkManganesTerc]").prop("checked", false);
}

//tratamento do radio isento LTCAT
$(document).on('change', "[name$='rbIsentoLTCAT']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencLTCAT]").attr('disabled', true);
        $("[id$=txtVencLTCAT]").val("");
        $('span.vencLTCAT').hide();
    } else {
        $("[id$=txtVencLTCAT]").removeAttr('disabled');
        $('span.vencLTCAT').show();
    }
});

function gerenciaIsentoLTCAT() {
    if ($("[id$=rbIsentoLTCAT] input:checked").val() == "N") {
        $("[id$=txtVencLTCAT]").removeAttr('disabled');
        $('span.vencLTCAT').show();
    } else {
        $("[id$=txtVencLTCAT]").attr('disabled', true);
        $('span.vencLTCAT').hide();
    }
}
//tratamento do radio isento PPR
$(document).on('change', "[name$='rbIsentoPPR']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPPR]").attr('disabled', true);         
        $("[id$=txtVencPPR]").val("");
        $('span.vencPPR').hide();
    } else {
        $("[id$=txtVencPPR]").removeAttr('disabled');
        $('span.vencPPR').show();
    }
});

function gerenciaIsentoPPR() {
    if ($("[id$=rbIsentoPPR] input:checked").val() == "N") {
        $("[id$=txtVencPPR]").removeAttr('disabled');
        $('span.vencPPR').show();
    } else {
        $("[id$=txtVencPPR]").attr('disabled', true);
        $('span.vencPPR').hide();
    }
}
//tratamento do radio isento PCA
$(document).on('change', "[name$='rbIsentoPCA']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPCA]").attr('disabled', true);
        $("[id$=txtVencPCA]").val("");
        $('span.vencPCA').hide();
    } else {
        $("[id$=txtVencPCA]").removeAttr('disabled');
        $('span.vencPCA').show();
    }
});

function gerenciaIsentoPCA() {
    if ($("[id$=rbIsentoPCA] input:checked").val() == "N") {
        $("[id$=txtVencPCA]").removeAttr('disabled');
        $('span.vencPCA').show();
    } else {
        $("[id$=txtVencPCA]").attr('disabled', true);
        $('span.vencPCA').hide();
    }
}
//tratamento do radio isento PGRS
$(document).on('change', "[name$='rbIsentoPGRS']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPGRS]").attr('disabled', true);
        $("[id$=txtVencPGRS]").val("");
        $('span.vencPGRS').hide();
    } else {
        $("[id$=txtVencPGRS]").removeAttr('disabled');
        $('span.vencPGRS').show();
    }
});

function gerenciaIsentoPGRS() {
    if ($("[id$=rbIsentoPGRS] input:checked").val() == "N") {
        $("[id$=txtVencPGRS]").removeAttr('disabled');
        $('span.vencPGRS').show();
    } else {
        $("[id$=txtVencPGRS]").attr('disabled', true);
        $('span.vencPGRS').hide();
    }
}
//tratamento do radio isento PS
$(document).on('change', "[name$='rbIsentoPS']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPS]").attr('disabled', true);
        $("[id$=txtVencPS]").val("");
        $('span.vencPS').hide();
    } else {
        $("[id$=txtVencPS]").removeAttr('disabled');
        $('span.vencPS').show();
    }
});

function gerenciaIsentoPS() {
    if ($("[id$=rbIsentoPS] input:checked").val() == "N") {
        $("[id$=txtVencPS]").removeAttr('disabled');
        $('span.vencPS').show();
    } else {
        $("[id$=txtVencPS]").attr('disabled', true);
        $('span.vencPS').hide();
    }
}
//tratamento do radio isento PCMAT
$(document).on('change', "[name$='rbIsentoPCMAT']", function () {
    if ($(this).val() == "S") {
        $("[id$=txtVencPCMAT]").attr('disabled', true);
        $("[id$=txtVencPCMAT]").val("");
        $('span.vencPCMAT').hide();
    } else {
        $("[id$=txtVencPCMAT]").removeAttr('disabled');
        $('span.vencPCMAT').show();
    }
});

function gerenciaIsentoPCMAT() {
    if ($("[id$=rbIsentoPCMAT] input:checked").val() == "N") {
        $("[id$=txtVencPCMAT]").removeAttr('disabled');
        $('span.vencPCMAT').show();
    } else {
        $("[id$=txtVencPCMAT]").attr('disabled', true);
        $('span.vencPCMAT').hide();
    }
}

//trata o collapse/icone dos panels
$(document).on('click', '.panel-heading span.clickable', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.addClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    } else {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.removeClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    }
})
