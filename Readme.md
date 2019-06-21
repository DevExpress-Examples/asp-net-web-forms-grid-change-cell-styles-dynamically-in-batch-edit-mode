<!-- default file list -->
*Files to look at*:

* **[Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))**
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/Default.aspx.vb))
<!-- default file list end -->
# ASPxGridView - How to change modified cell styles dynamically in Batch Edit mode
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/t466715)**
<!-- run online end -->


<p>If you're applying custom conditional formatting to ASPxGridView cells by using the <a href="https://documentation.devexpress.com/#aspnet/DevExpressWebASPxGridView_HtmlDataCellPreparedtopic">HtmlDataCellPrepared</a> event handler, this formatting will not be applied to the modified cells in Batch Edit mode because these modifications are stored on the client side until you press the "Save Changes" button. <br>In order to apply the same formatting to the modified values in this mode, it's necessary to set their style dynamically in the client-side <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_BatchEditEndEditingtopic">BatchEditEndEditing</a> event handler.<br>Add a custom attribute to each cell of the formatted column in the <a href="https://documentation.devexpress.com/#aspnet/DevExpressWebASPxGridView_HtmlDataCellPreparedtopic">HtmlDataCellPrepared</a> event handler as demonstrated in the <a href="https://www.devexpress.com/Support/Center/p/E5140">ASPxGridView - How to set a different color for the modified cell in different columns in Batch Edit mode</a> example. Set the grid's Styles.Row.CssClass property, and use this class and attribute to access the currently edited row's cell on the client side. Then, set the modified cell's style in the client-side <a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientGridView_BatchEditEndEditingtopic">BatchEditEndEditing</a> event handler based on the newly entered value.</p>

<br/>


