<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.18.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//code.jquery.com/jquery-1.12.1.min.js"></script>
    <script type="text/javascript">
        function OnBatchEditEndEditing(s, e) {
            var colorColumn = s.GetColumnByField("C1");
            var c1 = e.rowValues[colorColumn.index].value;
            window.setTimeout(function () {
                if (c1 > 0)
                    ChangeCellColor("Orange", e.visibleIndex, "C1");
                else
                    ChangeCellColor("Blue", e.visibleIndex, "C1");
            }, 50);
        }

        function OnFocusedCellChanging(s, e) {
            RestoreColors();
        }
        function OnBatchEditChangesCanceling(s, e) {
            RestoreColors();
        }

        //prevent an incorrect cell rendering
        function RestoreColors() {
            setTimeout(function () {
                var i;
                for (i = 0; i <= 9; i++) {
                    var col = $(".row[id$=" + i + "] td[fieldName=" + "C1" + "]");
                    var col1value = col[0].innerText;
                    if (parseInt(col1value) > 0) {
                        ChangeCellColor("Orange", i, "C1");
                    }
                    else {
                        ChangeCellColor("Blue", i, "C1");
                    }
                }
            }, 10);
        }
        function ChangeCellColor(color, index, colName) {
            var col = $(".row[id$=" + index + "] td[fieldName=" + colName + "]");
            if (color == "Orange") {
                col.addClass("orangeCell");
                col.removeClass("blueCell");
            }
            else {
                col.addClass("blueCell");
                col.removeClass("orangeCell");
            }
        }
    </script>
    <style type="text/css">
        .orangeCell {
            color: orange !important;
        }

        .blueCell {
            color: blue !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="Grid" runat="server" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate" OnHtmlDataCellPrepared="Grid_HtmlDataCellPrepared"
                OnRowInserting="Grid_RowInserting" OnRowUpdating="Grid_RowUpdating" OnRowDeleting="Grid_RowDeleting">
                <Columns>
                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowDeleteButton="true" />
                    <dx:GridViewDataColumn FieldName="C1" />
                    <dx:GridViewDataSpinEditColumn FieldName="C2" />
                    <dx:GridViewDataTextColumn FieldName="C3" />
                    <dx:GridViewDataCheckColumn FieldName="C4" />
                    <dx:GridViewDataDateColumn FieldName="C5" />
                </Columns>
                <Styles>
                    <Row CssClass="row"></Row>
                </Styles>
                <SettingsEditing Mode="Batch" />
                <ClientSideEvents BatchEditEndEditing="OnBatchEditEndEditing" BatchEditChangesCanceling="OnBatchEditChangesCanceling" FocusedCellChanging="OnFocusedCellChanging" />
            </dx:ASPxGridView>
        </div>
    </form>
</body>
</html>
