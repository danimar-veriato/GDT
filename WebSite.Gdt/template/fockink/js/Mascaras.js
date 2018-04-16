function formatamascara(campo, evt, formato) {
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    var result = "";
    var maskidx = formato.length - 1;
    var error = false;
    var valor = campo.value;
    var posfinal = false;
    if (campo.setselectionrange) {
        if (campo.selectionstart == valor.length)
            posfinal = true;
    }

    valor = valor.replace(/[^0123456789xx]/g, '');
    for (var validx = valor.length - 1; validx >= 0 && maskidx >= 0; --maskidx) {
        var chr = valor.charat(validx);
        var chrmask = formato.charat(maskidx);
        switch (chrmask) {
            case '#':
                if (!(/\d/.test(chr)))
                    error = true;
                result = chr + result;
                --validx;
                break;
            case '@':
                result = chr + result;
                --validx;
                break;
            default:
                result = chrmask + result;
        }
    }

    campo.value = result;
    campo.style.color = error ? 'red' : '';
    if (posfinal) {
        campo.selectionstart = result.length;
        campo.selectionend = result.length;
    }
    return result;
}

// formata o campo valor monetário
function formatavalor(campo, evt) {
    //1.000.000,00
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    if (vr.length > 0) {
        vr = parseFloat(vr.toString()).toString();
        tam = vr.length;

        if (tam == 1)
            campo.value = "0,0" + vr;
        if (tam == 2)
            campo.value = "0," + vr;
        if ((tam > 2) && (tam <= 5)) {
            campo.value = vr.substr(0, tam - 2) + ',' + vr.substr(tam - 2, tam);
        }
        if ((tam >= 6) && (tam <= 8)) {
            campo.value = vr.substr(0, tam - 5) + '.' + vr.substr(tam - 5, 3) + ',' + vr.substr(tam - 2, tam);
        }
        if ((tam >= 9) && (tam <= 11)) {
            campo.value = vr.substr(0, tam - 8) + '.' + vr.substr(tam - 8, 3) + '.' + vr.substr(tam - 5, 3) + ',' + vr.substr(tam - 2, tam);
        }
        if ((tam >= 12) && (tam <= 14)) {
            campo.value = vr.substr(0, tam - 11) + '.' + vr.substr(tam - 11, 3) + '.' + vr.substr(tam - 8, 3) + '.' + vr.substr(tam - 5, 3) + ',' + vr.substr(tam - 2, tam);
        }
        if ((tam >= 15) && (tam <= 18)) {
            campo.value = vr.substr(0, tam - 14) + '.' + vr.substr(tam - 14, 3) + '.' + vr.substr(tam - 11, 3) + '.' + vr.substr(tam - 8, 3) + '.' + vr.substr(tam - 5, 3) + ',' + vr.substr(tam - 2, tam);
        }
    }
    movimentacursor(campo, xpos);
}

// formata data no padrão dd/mm/yyyy
function formatadata(campo, evt) {
    var xpos = posicaocursor(campo);
    //dd/mm/yyyy
    evt = getevent(evt);

    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;
    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam >= 2 && tam < 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2);
    if (tam == 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/';
    if (tam > 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/' + vr.substr(4);

    movimentacursor(campo, xpos);
}

//descobre qual a posição do cursor no campo
function posicaocursor(textarea) {
    var pos = 0;
    if (typeof (document.selection) != 'undefined') {
        //ie
        var range = document.selection.createrange();
        var i = 0;
        for (i = textarea.value.length; i > 0; i--) {
            if (range.movestart('character', 1) == 0)
                break;
        }
        pos = i;
    }
    if (typeof (textarea.selectionstart) != 'undefined') {
        //firefox
        pos = textarea.selectionstart;
    }

    if (pos == textarea.value.length)
        return 0; //retorna 0 quando não precisa posicionar o elemento
    else
        return pos; //posição do cursor
}

// move o cursor para a posição pos
function movimentacursor(textarea, pos) {
    if (pos <= 0)
        return; //se a posição for 0 não reposiciona

    if (typeof (document.selection) != 'undefined') {
        //ie
        var orange = textarea.createtextrange();
        var length = 1;
        var startindex = pos;

        orange.movestart("character", -textarea.value.length);
        orange.moveend("character", -textarea.value.length);
        orange.movestart("character", pos);
        //orange.moveend("character", pos);
        orange.select();
        textarea.focus();
    }
    if (typeof (textarea.selectionstart) != 'undefined') {
        //firefox
        textarea.selectionstart = pos;
        textarea.selectionend = pos;
    }
}

//formata data e hora no padrão dd/mm/yyyy hh:mm
function formatadataehora(campo, evt) {
    xpos = posicaocursor(campo);
    //dd/mm/yyyy
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;
    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam >= 2 && tam < 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2);
    if (tam == 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/';
    if (tam > 4)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/' + vr.substr(4);
    if (tam > 8 && tam < 11)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/' + vr.substr(4, 4) + ' ' + vr.substr(8, 2);
    if (tam >= 11)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2, 2) + '/' + vr.substr(4, 4) + ' ' + vr.substr(8, 2) + ':' + vr.substr(10);

    campo.value = campo.value.substr(0, 16);
    //    if(xpos == 2 || xpos == 5)
    //        xpos = xpos +1;
    //    if(xpos == 11 || xpos == 14)
    //        xpos = xpos +2;
    movimentacursor(campo, xpos);
}

// formata só números
function formatainteiro(campo, evt) {
    //1234567890
    xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    campo.value = filtranumeros(filtracampo(campo));
    movimentacursor(campo, xpos);
}

// formata hora no padrao hh:mm
function formatahora(campo, evt) {
    //hh:mm
    xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));

    if (tam == 2)
        campo.value = vr.substr(0, 2) + ':';
    if (tam > 2 && tam < 5)
        campo.value = vr.substr(0, 2) + ':' + vr.substr(2);
    //    if(xpos == 2)
    //        xpos = xpos + 1;
    movimentacursor(campo, xpos);
}

// limpa todos os caracteres especiais do campo solicitado
function filtracampo(campo) {
    var s = "";
    var cp = "";
    vr = campo.value;
    tam = vr.length;
    for (i = 0; i < tam; i++) {
        if (vr.substring(i, i + 1) != "/"
                  && vr.substring(i, i + 1) != "-"
                  && vr.substring(i, i + 1) != "."
                  && vr.substring(i, i + 1) != "("
                  && vr.substring(i, i + 1) != ")"
                  && vr.substring(i, i + 1) != ":"
                  && vr.substring(i, i + 1) != ",") {
            s = s + vr.substring(i, i + 1);
        }
    }
    return s;
    //return campo.value.replace("/", "").replace("-", "").replace(".", "").replace(",", "")
}

// limpa todos caracteres que não são números
function filtranumeros(campo) {
    var s = "";
    var cp = "";
    vr = campo;
    tam = vr.length;
    for (i = 0; i < tam; i++) {
        if (vr.substring(i, i + 1) == "0" ||
                  vr.substring(i, i + 1) == "1" ||
                  vr.substring(i, i + 1) == "2" ||
                  vr.substring(i, i + 1) == "3" ||
                  vr.substring(i, i + 1) == "4" ||
                  vr.substring(i, i + 1) == "5" ||
                  vr.substring(i, i + 1) == "6" ||
                  vr.substring(i, i + 1) == "7" ||
                  vr.substring(i, i + 1) == "8" ||
                  vr.substring(i, i + 1) == "9") {
            s = s + vr.substring(i, i + 1);
        }
    }
    return s;
    //return campo.value.replace("/", "").replace("-", "").replace(".", "").replace(",", "")
}

// limpa todos caracteres que não são letras
function filtracaracteres(campo) {
    vr = campo;
    for (i = 0; i < tam; i++) {
        //caracter
        if (vr.charcodeat(i) != 32 && vr.charcodeat(i) != 94 && (vr.charcodeat(i) < 65 ||
              (vr.charcodeat(i) > 90 && vr.charcodeat(i) < 96) ||
                  vr.charcodeat(i) > 122) && vr.charcodeat(i) < 192) {
            vr = vr.replace(vr.substr(i, 1), "");
        }
    }
    return vr;
}

// limpa todos caracteres que não são números, menos a vírgula
function filtranumeroscomvirgula(campo) {
    var s = "";
    var cp = "";
    vr = campo;
    tam = vr.length;
    var complemento = 0; //flag paga contar o número de virgulas
    for (i = 0; i < tam; i++) {
        if ((vr.substring(i, i + 1) == "," && complemento == 0 && s != "") ||
                  vr.substring(i, i + 1) == "0" ||
                  vr.substring(i, i + 1) == "1" ||
                  vr.substring(i, i + 1) == "2" ||
                  vr.substring(i, i + 1) == "3" ||
                  vr.substring(i, i + 1) == "4" ||
                  vr.substring(i, i + 1) == "5" ||
                  vr.substring(i, i + 1) == "6" ||
                  vr.substring(i, i + 1) == "7" ||
                  vr.substring(i, i + 1) == "8" ||
                  vr.substring(i, i + 1) == "9") {
            if (vr.substring(i, i + 1) == ",")
                complemento = complemento + 1;
            s = s + vr.substring(i, i + 1);
        }
    }
    return s;
}

function formatamesano(campo, evt) {
    //mm/yyyy
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam >= 2)
        campo.value = vr.substr(0, 2) + '/' + vr.substr(2);
    movimentacursor(campo, xpos);
}

function formatacnpj(campo, evt) {
    //99.999.999/9999-99
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam >= 2 && tam < 5)
        campo.value = vr.substr(0, 2) + '.' + vr.substr(2);
    else if (tam >= 5 && tam < 8)
        campo.value = vr.substr(0, 2) + '.' + vr.substr(2, 3) + '.' + vr.substr(5);
    else if (tam >= 8 && tam < 12)
        campo.value = vr.substr(0, 2) + '.' + vr.substr(2, 3) + '.' + vr.substr(5, 3) + '/' + vr.substr(8);
    else if (tam >= 12)
        campo.value = vr.substr(0, 2) + '.' + vr.substr(2, 3) + '.' + vr.substr(5, 3) + '/' + vr.substr(8, 4) + '-' + vr.substr(12);
    movimentacursor(campo, xpos);
}

function formatacpf(campo, evt) {
    //999.999.999-99
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;
    if (tam >= 3 && tam < 6)
        campo.value = vr.substr(0, 3) + '.' + vr.substr(3);
    else if (tam >= 6 && tam < 9)
        campo.value = vr.substr(0, 3) + '.' + vr.substr(3, 3) + '.' + vr.substr(6);
    else if (tam >= 9)
        campo.value = vr.substr(0, 3) + '.' + vr.substr(3, 3) + '.' + vr.substr(6, 3) + '-' + vr.substr(9);
    movimentacursor(campo, xpos);
}

function formatadouble(campo, evt) {
    //18,53012
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    campo.value = filtranumeroscomvirgula(campo.value);
    movimentacursor(campo, xpos);
}

function formatatelefone(campo, evt) {
    //(00) 0000-0000
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam == 1)
        campo.value = '(' + vr;
    else if (tam >= 2 && tam < 6)
        campo.value = '(' + vr.substr(0, 2) + ') ' + vr.substr(2);
    else if (tam >= 6)
        campo.value = '(' + vr.substr(0, 2) + ') ' + vr.substr(2, 4) + '-' + vr.substr(6);

    //(
    //    if(xpos == 1 || xpos == 3 || xpos == 5 || xpos == 9)
    //        xpos = xpos +1
    movimentacursor(campo, xpos);
}

function formatatexto(campo, evt, smascara) {
    //nome com inicial maiuscula.
    evt = getevent(evt);
    xpos = posicaocursor(campo);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;
    vr = campo.value = filtracaracteres(filtracampo(campo));
    tam = vr.length;

    if (smascara == "aa" || smascara == "xx") {
        var valor = campo.value.tolowercase();
        var count = campo.value.split(" ").length - 1;
        var i;
        var pos = 0;
        var valorini;
        var valormei;
        var valorfim;
        valor = valor.substring(0, 1).touppercase() + valor.substring(1, valor.length);
        for (i = 0; i < count; i++) {
            pos = valor.indexof(" ", pos + 1);
            valorini = valor.substring(0, valor.indexof(" ", pos - 1)) + " ";
            valormei = valor.substring(valor.indexof(" ", pos) + 1, valor.indexof(" ", pos) + 2).touppercase();
            valorfim = valor.substring(valor.indexof(" ", pos) + 2, valor.length);
            valor = valorini + valormei + valorfim;
        }
        campo.value = valor;
    }
    if (smascara == "aaa" || smascara == "xxx") {
        var valor = campo.value.tolowercase();
        var count = campo.value.split(" ").length - 1;
        var i;
        var pos = 0;
        var valorini;
        var valormei;
        var valorfim;
        var ligacao = false;
        var chrligacao = array("de", "da", "do", "para", "e")
        valor = valor.substring(0, 1).touppercase() + valor.substring(1, valor.length);
        for (i = 0; i < count; i++) {
            ligacao = false;
            pos = valor.indexof(" ", pos + 1);
            valorini = valor.substring(0, valor.indexof(" ", pos - 1)) + " ";
            for (var a = 0; a < chrligacao.length; a++) {
                if (valor.substring(valorini.length, valor.indexof(" ", valorini.length)).tolowercase() == chrligacao[a].tolowercase()) {
                    ligacao = true;
                    break;
                }
                else if (ligacao == false && valor.indexof(" ", valorini.length) == -1) {
                    if (valor.substring(valorini.length, valor.length).tolowercase() == chrligacao[a].tolowercase()) {
                        ligacao = true;
                        break;
                    }
                }
            }
            if (ligacao == true) {
                valormei = valor.substring(valor.indexof(" ", pos) + 1, valor.indexof(" ", pos) + 2).tolowercase();
            }
            else {
                valormei = valor.substring(valor.indexof(" ", pos) + 1, valor.indexof(" ", pos) + 2).touppercase();
            }
            valorfim = valor.substring(valor.indexof(" ", pos) + 2, valor.length);
            valor = valorini + valormei + valorfim;
        }

        campo.value = valor;
    }
    movimentacursor(campo, xpos);
    return true;
}

// formata o campo cep
function formatacep(campo, evt) {
    //312555-650
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    vr = campo.value = filtranumeros(filtracampo(campo));
    tam = vr.length;

    if (tam < 5)
        campo.value = vr;
    else if (tam == 5)
        campo.value = vr + '-';
    else if (tam > 5)
        campo.value = vr.substr(0, 5) + '-' + vr.substr(5);
    movimentacursor(campo, xpos);
}

function formatacartaocredito(campo, evt) {
    //0000.0000.0000.0000
    var xpos = posicaocursor(campo);
    evt = getevent(evt);
    var tecla = getkeycode(evt);
    if (!teclavalida(tecla))
        return;

    var vr = campo.value = filtranumeros(filtracampo(campo));
    var tammax = 16;
    var tam = vr.length;

    if (tam < tammax && tecla != 8)
    { tam = vr.length + 1; }

    if (tam < 5)
    { campo.value = vr; }
    if ((tam > 4) && (tam < 9))
    { campo.value = vr.substr(0, 4) + '.' + vr.substr(4, tam - 4); }
    if ((tam > 8) && (tam < 13))
    { campo.value = vr.substr(0, 4) + '.' + vr.substr(4, 4) + '.' + vr.substr(8, tam - 4); }
    if (tam > 12)
    { campo.value = vr.substr(0, 4) + '.' + vr.substr(4, 4) + '.' + vr.substr(8, 4) + '.' + vr.substr(12, tam - 4); }
    movimentacursor(campo, xpos);
}


//recupera tecla

//evita criar mascara quando as teclas são pressionadas
function teclavalida(tecla) {
    if (tecla == 8 //backspace
        //esta evitando o post, quando são pressionadas estas teclas.
        //foi comentado pois, se for utilizado o evento texchange, é necessario o post.
           || tecla == 9 //tab
           || tecla == 27 //esc
           || tecla == 16 //shif tab
           || tecla == 45 //insert
           || tecla == 46 //delete
           || tecla == 35 //home
           || tecla == 36 //end
           || tecla == 37 //esquerda
           || tecla == 38 //cima
           || tecla == 39 //direita
           || tecla == 40)//baixo
        return false;
    else
        return true;
}

// recupera o evento do form
function getevent(evt) {
    if (!evt) evt = window.event; //ie
    return evt;
}
//recupera o código da tecla que foi pressionado
function getkeycode(evt) {
    var code;
    if (typeof (evt.keycode) == 'number')
        code = evt.keycode;
    else if (typeof (evt.which) == 'number')
        code = evt.which;
    else if (typeof (evt.charcode) == 'number')
        code = evt.charcode;
    else
        return 0;

    return code;
}