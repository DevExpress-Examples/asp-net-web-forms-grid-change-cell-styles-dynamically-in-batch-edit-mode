<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <script src="//code.jquery.com/jquery-1.12.1.min.js"></script>  
  <style type="text/css">
    .orangeCell {
      color: orange !important;
    }
    .blueCell {
      color: blue !important;
    }
</style>

 <script>
  function OnBatchEditEndEditing(s, e) {
   var colorColumn = s.GetColumnByField("C1");
   var c1 = e.rowValues[colorColumn.index].value;
   window.setTimeout(function () {
   if (c1 > 0)
     $(".row[id$=" + e.visibleIndex + "] td[fieldName=C1]").addClass("orangeCell");
   else
     $(".row[id$=" + e.visibleIndex + "] td[fieldName=C1]").addClass("blueCell");
   }, 50);
  }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
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
      <ClientSideEvents BatchEditEndEditing="OnBatchEditEndEditing" />
     </dx:ASPxGridView>
    </form>
</body>
</html>
