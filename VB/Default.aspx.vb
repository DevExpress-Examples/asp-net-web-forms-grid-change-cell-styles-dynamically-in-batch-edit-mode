﻿Imports Microsoft.VisualBasic
Imports DevExpress.Web.Data
Imports System
Imports System.Collections.Generic
Imports System.Collections.Specialized
Imports System.ComponentModel
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected ReadOnly Property GridData() As List(Of GridDataItem)
		Get
			Dim key = "34FAA431-CF79-4869-9488-93F6AAE81263"
			If (Not IsPostBack) OrElse Session(key) Is Nothing Then
				Session(key) = Enumerable.Range(0, 100).Select(Function(i) New GridDataItem With {.ID = i, .C1 = i Mod 2, .C2 = i * 0.5 Mod 3, .C3 = "C3 " & i, .C4 = i Mod 2 = 0, .C5 = New DateTime(2013 + i, 12, 16)}).ToList()
			End If
			Return CType(Session(key), List(Of GridDataItem))
		End Get
	End Property
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Grid.DataSource = GridData
		Grid.DataBind()
	End Sub
	Protected Sub Grid_RowInserting(ByVal sender As Object, ByVal e As ASPxDataInsertingEventArgs)
		InsertNewItem(e.NewValues)
		CancelEditing(e)
	End Sub
	Protected Sub Grid_RowUpdating(ByVal sender As Object, ByVal e As ASPxDataUpdatingEventArgs)
		UpdateItem(e.Keys, e.NewValues)
		CancelEditing(e)
	End Sub
	Protected Sub Grid_RowDeleting(ByVal sender As Object, ByVal e As ASPxDataDeletingEventArgs)
		DeleteItem(e.Keys, e.Values)
		CancelEditing(e)
	End Sub

	Protected Sub Grid_BatchUpdate(ByVal sender As Object, ByVal e As ASPxDataBatchUpdateEventArgs)

		For Each args In e.InsertValues
			InsertNewItem(args.NewValues)
		Next args
		For Each args In e.UpdateValues
			UpdateItem(args.Keys, args.NewValues)
		Next args
		For Each args In e.DeleteValues
			DeleteItem(args.Keys, args.Values)
		Next args

		e.Handled = True
	End Sub
	Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
		Dim item = New GridDataItem() With {.ID = GridData.Count}
		LoadNewValues(item, newValues)
		GridData.Add(item)
		Return item
	End Function
	Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
		Dim id = Convert.ToInt32(keys("ID"))
		Dim item = GridData.First(Function(i) i.ID = id)
		LoadNewValues(item, newValues)
		Return item
	End Function
	Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal values As OrderedDictionary) As GridDataItem
		Dim id = Convert.ToInt32(keys("ID"))
		Dim item = GridData.First(Function(i) i.ID = id)
		GridData.Remove(item)
		Return item
	End Function
	Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary)
		item.C1 = Convert.ToInt32(values("C1"))
		item.C2 = Convert.ToDouble(values("C2"))
		item.C3 = Convert.ToString(values("C3"))
		item.C4 = Convert.ToBoolean(values("C4"))
		item.C5 = Convert.ToDateTime(values("C5"))
	End Sub
	Protected Sub CancelEditing(ByVal e As CancelEventArgs)
		e.Cancel = True
		Grid.CancelEdit()
	End Sub
	Public Class GridDataItem
		Private privateID As Integer
		Public Property ID() As Integer
			Get
				Return privateID
			End Get
			Set(ByVal value As Integer)
				privateID = value
			End Set
		End Property
		Private privateC1 As Integer
		Public Property C1() As Integer
			Get
				Return privateC1
			End Get
			Set(ByVal value As Integer)
				privateC1 = value
			End Set
		End Property
		Private privateC2 As Double
		Public Property C2() As Double
			Get
				Return privateC2
			End Get
			Set(ByVal value As Double)
				privateC2 = value
			End Set
		End Property
		Private privateC3 As String
		Public Property C3() As String
			Get
				Return privateC3
			End Get
			Set(ByVal value As String)
				privateC3 = value
			End Set
		End Property
		Private privateC4 As Boolean
		Public Property C4() As Boolean
			Get
				Return privateC4
			End Get
			Set(ByVal value As Boolean)
				privateC4 = value
			End Set
		End Property
		Private privateC5 As DateTime
		Public Property C5() As DateTime
			Get
				Return privateC5
			End Get
			Set(ByVal value As DateTime)
				privateC5 = value
			End Set
		End Property
	End Class
	Protected Sub Grid_HtmlDataCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewTableDataCellEventArgs)
		Dim c1 As Integer = Convert.ToInt32(e.GetValue("C1"))
		If e.DataColumn.FieldName <> "C1" Then
			Return
		End If
		e.Cell.Attributes.Add("fieldName", e.DataColumn.FieldName)
		If c1 > 0 Then
			e.Cell.ForeColor = System.Drawing.Color.Orange
		Else
			e.Cell.ForeColor = System.Drawing.Color.Blue
		End If
	End Sub
End Class