USE [ODS1]
GO
/****** Object:  StoredProcedure [dbo].[InvoiceGroup_Print]    Script Date: 30/09/2022 08:19:51 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[InvoiceGroup_Print]
 	@ID bigINT ,
   @guidUser uniqueidentifier,
   @GroupGuid bigint
AS
BEGIN

  update dbo.Invoice set CountPrint=(select Cast(ISNULL(CountPrint,0) as int)+1 from dbo.Invoice where ID=@ID )
   where  ID=@ID 
   

  declare @NameUserPrint nvarchar(500)
select @NameUserPrint=NameA from [dbo].[User] where guid=@guidUser


declare @tbCustomer TABLE (
id bigint,
[CardNo] [nvarchar](50) NULL,
	[NameA] [nvarchar](150) NULL,
	[NameL] [nvarchar](150) NULL,
	[Note] [nvarchar](350) NULL,
	[Address] [nvarchar](350) NULL,
	[AccountNumber] [nvarchar](350) NULL,
	[Telephone1] [nvarchar](350) NULL,
	[Telephone2] [nvarchar](350) NULL,
	[Email] [nvarchar](350) NULL,
	[website] [nvarchar](350) NULL,
	CreditLimit decimal(18,5))
	insert  into @tbCustomer
	SELECT [id]     
      ,[CardNo]
      ,[NameA]
      ,[NameL]
      ,[Note]   
      ,[Address]
      ,[AccountNumber]
      ,[Telephone1]
      ,[Telephone2]
      ,[Email]
      ,[website]
	,isnull([CreditLimit],0)CreditLimit
  FROM [dbo].[View_CustomerCard]
	 WHERE 
   IsDelete=0



declare @tbVender TABLE (
id bigint,
[CardNo] [nvarchar](50) NULL,
	[NameA] [nvarchar](150) NULL,
	[NameL] [nvarchar](150) NULL,
	[Note] [nvarchar](350) NULL,
	[Address] [nvarchar](350) NULL,
	[AccountNumber] [nvarchar](350) NULL,
	[Telephone1] [nvarchar](350) NULL,
	[Telephone2] [nvarchar](350) NULL,
	[Email] [nvarchar](350) NULL,
	[website] [nvarchar](350) NULL,
	CreditLimit decimal(18,5))
	insert  into @tbVender
	SELECT [id]     
      ,[CardNo]
      ,[NameA]
      ,[NameL]
      ,[Note]   
      ,[Address]
      ,[AccountNumber]
      ,[Telephone1]
      ,[Telephone2]
      ,[Email]
      ,[website]
	,isnull([CreditLimit],0)CreditLimit
  FROM [dbo].[View_VendersCard]
	 WHERE 
   IsDelete=0


SELECT Invoice. [ID]
      ,Invoice.[guid]
      ,Invoice.[Branch_ID]
      ,Invoice.[Currency_ID]
      ,Invoice.[Ratio]
      ,Invoice.[Contact_ID]
      ,Invoice.[OperationDate]
      ,Invoice.[Serial]
      ,Invoice.[DocStatus_ID]
      ,Invoice.[IsDelete]
      ,Invoice.[IsHide]
      ,Invoice.[CreateDate]
      ,Invoice.[CreatedBy_ID]
      ,Invoice.[ApproveDate]
      ,Invoice.[ApprovedBy_ID]
      ,Invoice.[CancelDate]
      ,Invoice.[CanceledBy_ID]
      ,Invoice.[CostCenter_ID]
      ,Invoice.[Stor_ID]
      ,Invoice.[Notes]
      ,Invoice.[TotalAmount]
      ,Invoice.[PercentageDiscount]
      ,Invoice.[CashDiscount]
      ,Invoice.[TotalDiscount]
      ,Invoice.[TotalTax]
      ,Invoice.[GrossTotalAmount]
      ,Invoice.[UserRefNo]
      ,Invoice.[EntryType]
      ,Invoice.[SalesOrder_ID]
      ,Invoice.[SalesRep_ID]
      ,Invoice.[Additionals]
      ,Invoice.[ContactMesure_ID]
      ,Invoice.[DueDate]
      ,Invoice.[IsPos]
      ,Invoice.[IsClosed]
      ,Invoice.[IsFinish]
      ,Invoice.[YearMonthDayDubai]
      ,Invoice.[SerialNumber]
      ,Invoice.[TypeDelivery]
      ,Invoice.[TypeDeliveryName]
      ,Invoice.[DateDelivery]
      ,Invoice.[DescriptionReady]
      ,Invoice.[Driver_ID]
      ,Invoice.[IsTax]
      ,Invoice.[TotalTaxUpdate]
      ,Invoice.[DateUpdateTax]
      ,Invoice.[TypeTax]
      ,Invoice.[usrRefDate]
      ,Invoice.[CustomerName]
      ,Invoice.[CustomerMobile]
      ,Invoice.[ProjectRef]
      ,Invoice.[ContactPerson]
      ,Invoice.[CustomerRepresentative]
      ,Invoice.[CustomerNbrTax]
      ,Invoice.[CustomerAddress]
      ,Invoice.[IcjStock]
      ,Invoice.[OperationInvoice]
      ,Invoice.[DateFinish]
      ,Invoice.[DeliveryDays]
      ,Invoice.[cell_1]
      ,Invoice.[cell_2]
      ,Invoice.[cell_3]
      ,Invoice.[cell_4]
      ,Invoice.[cell_5]
      ,Invoice.[cell_6]
      ,Invoice.[cell_7]
      ,Invoice.[cell_8]
      ,Invoice.[cell_9]
      ,Invoice.[cell_10]
      ,Invoice.[cell_dat1]
      ,Invoice.[cell_dat2]
      ,Invoice.[cell_dat3]
      ,Invoice.[cell_dat4]
	  ,[InvoiceDetails].[ID]
      ,[InvoiceDetails].[Master_ID]
      ,[InvoiceDetails].[Store_ID]
      ,[InvoiceDetails].[Item_ID]            CollIDIteme
	  ,item.CardNo                           CollCode
	  ,item.NameA                            CollItemName
	   ,item.MaxQty
	    ,item.MiniQty
		 ,item.NameL itemNameL
		  ,item.Note  itemNote
		   ,item.Pic  itemPic
      ,[InvoiceDetails].[UnitCost]           CollPrice
      ,[InvoiceDetails].[Quantity]           CollQty
      ,[InvoiceDetails].[Uom_ID]
      ,[InvoiceDetails].[Batch_ID]
      ,[InvoiceDetails].[Tax_ID]
      ,[InvoiceDetails].[PercentageDiscount]
      ,[InvoiceDetails].[CashDiscount]        CollDisc
      ,[InvoiceDetails].[TotalTax]            CollVat
	  ,(([InvoiceDetails].[UnitCost] *[InvoiceDetails].[Quantity])-[InvoiceDetails].[CashDiscount])CollTotal
	  , (([InvoiceDetails].[UnitCost] *[InvoiceDetails].[Quantity])-[InvoiceDetails].[CashDiscount]+(   case when invoice.TypeTax =5 then  [InvoiceDetails].[TotalTax] else 0 end))CollTotalAndVat
      ,[InvoiceDetails].[Notes]               CollNotes
      ,[InvoiceDetails].[QtyInNumber]
      ,[InvoiceDetails].[Capacity]
      ,[InvoiceDetails].[ItemDescription]
      ,[InvoiceDetails].[IDCodeOperation]
      ,[InvoiceDetails].[Policy]
      ,[InvoiceDetails].[InvoiceDate]
      ,[InvoiceDetails].[Capacities]
      ,[InvoiceDetails].[IsGift]
      ,[InvoiceDetails].[UnitCostInit]
      ,[InvoiceDetails].[ParcentTax]          CollVatRatio
      ,[InvoiceDetails].[CostCenter_ID]       CollCostCid
      ,[InvoiceDetails].[extra]
      ,[InvoiceDetails].[ExpireDateP]
      ,[InvoiceDetails].[GuaranteeEnd]
      ,[InvoiceDetails].[CLength]
      ,[InvoiceDetails].[CDisplay]
      ,[InvoiceDetails].[CSize]
      ,[InvoiceDetails].[Cnumber]
      ,[InvoiceDetails].[Cweight]
      ,[InvoiceDetails].[CSerialNumber]
	   ,[Barcode].[ID]                        CollUnitid
	    ,[unititem].[NameA]                   CollUnit
		,isnull(ItemsBatches.id  ,'')                    CollItemsBatchesid
		,isnull(ItemsBatches.BatchName ,'')              CollItemsBatches
		,@NameUserPrint NameUserPrint
		,[Companye].[NameA] [CompanyeNameA]
      ,[Companye].[NameL] [CompanyeNameL]
      ,[Companye].[Note]  [CompanyeNote]
      ,[Companye].[Address] [CompanyeAddress]
      ,[Companye].[TaxNumber] [CompanyeTaxNumber]
      ,[Companye].[Telephone1] [CompanyeTelephone1]
      ,[Companye].[Telephone2] [CompanyeTelephone2]
      ,[Companye].[Email]  [CompanyeEmail]
      ,[Companye].[website] [Companyewebsite]
      ,[Companye].[LogCompany] [CompanyeLogCompany]
	  ,Branchs.[CardNo] BranchsCardNo
      ,Branchs.[NameA] BranchsNameA
      ,Branchs.[NameL] BranchsNameL
	   ,CostCenters.[CardNo] CostCentersCardNo
      ,CostCenters.[NameA] CostCentersNameA
      ,CostCenters.[NameL] CostCentersNameL
	  ,SalesRep.[CardNo] SalesRepCardNo
      ,SalesRep.[NameA] SalesRepNameA
      ,SalesRep.[NameL] SalesRepNameL
	  ,Store.[CardNo] StoreRepCardNo
      ,Store.[NameA] StoreRepNameA
      ,Store.[NameL] StoreRepNameL
	   ,Driver.[CardNo] DriverRepCardNo
      ,Driver.[NameA] DriverRepNameA
      ,Driver.[NameL] DriverRepNameL
	  ,StoreMaster.[CardNo] StoreMasterRepCardNo
      ,StoreMaster.[NameA] StoreMasterRepNameA
      ,StoreMaster.[NameL] StoreMasterRepNameL
	  ,CostCentersMaster.[CardNo] CostCentersMasterCardNo
      ,CostCentersMaster.[NameA] CostCentersMasterNameA
      ,CostCentersMaster.[NameL] CostCentersMasterNameL
	  ,Currency.[CardNo] CurrencyCardNo
      ,Currency.[NameA] CurrencyNameA
      ,Currency.[NameL] CurrencyNameL
	  ,COALESCE(tbCustomer.CardNo, tbVender.CardNo)CustomerCardNo
	  ,COALESCE(tbCustomer.NameA, tbVender.NameA)CustomerNameA
	  ,COALESCE(tbCustomer.NameL, tbVender.NameL)CustomerNameL
	  ,COALESCE(tbCustomer.Note, tbVender.Note)CustomerNote
	  ,COALESCE(tbCustomer.Address, tbVender.Address)CustomerAddress
	  ,COALESCE(tbCustomer.AccountNumber, tbVender.AccountNumber)CustomerAccountNumber
	  ,COALESCE(tbCustomer.Telephone1, tbVender.Telephone1)CustomerTelephone1
	  ,COALESCE(tbCustomer.Telephone2, tbVender.Telephone2)CustomerTelephone2
	  ,COALESCE(tbCustomer.Email, tbVender.Email)CustomerEmail
	  ,COALESCE(tbCustomer.website, tbVender.website)Customerwebsite
	  ,COALESCE(tbCustomer.CreditLimit, tbVender.CreditLimit)CustomerCreditLimit
	  ,GeneralAttributes.AttName TypeTax_A
      ,GeneralAttributes.AttNameEN TypeTax_l
	  ,dbo.FNTafkeet(Invoice.GrossTotalAmount,Invoice.Currency_ID) ArabicGrossTotal 
	   ,Invoice.CountPrint
	   ,[dbo].[fun_Getpayibill](Invoice.guid) GetInv_paypos
	   ,(select isnull(sum(total),0) from [dbo].[Inv_paypos] where [Inv_paypos].guid_Inv=Invoice.guid)GettotalInv_paypos
      ,tostore.[CardNo] toStoreRepCardNo
      ,tostore.[NameA] toStoreRepNameA
      ,tostore.[NameL] toStoreRepNameL
	   ,ToBranch.[CardNo] ToBranchsCardNo
      ,ToBranch.[NameA] ToBranchsNameA
      ,ToBranch.[NameL] ToBranchsNameL
     ,ItemeMaster.CardNo    ItemeMasterCardNo                           
	  ,ItemeMaster.NameA      ItemeMasterNameA                         
	   ,ItemeMaster.MaxQty  ItemeMasterMaxQty
	    ,ItemeMaster.MiniQty
		 ,ItemeMaster.NameL   ItemeMasterNameL  
		  ,ItemeMaster.Note  itemMasterNote
		   ,ItemeMaster.Pic  itemMasterPic
		  , Invoice.QtyItemeMaster
		  ,Invoicetemplatemmanufacturing.Serial InvoicetemplatemmanufacturingSerial
		  ,Invoicetemplatemmanufacturing.Notes  InvoicetemplatemmanufacturingNotes
		    ,''QrCode
			, shpos.NameA shposNameA,shpos.NameL shposNameL ,
						 shpos.BeginBalance shposBeginBalance, shpos.CardNo shposCardNo ,shpos.DateCreate shposDateCreate ,shpos.DateClose  shposDateClose,
						 shpos.IsClose  shposIsClose,
						 usercreateshiftpos.NameA  usercreateshiftposNameA,usercloseshiftpos.NameA usercloseshiftposNameA
						 ,requesttype.AttName requesttypeName,RestaurantTable.NameA RestaurantTableNameA
  FROM [dbo].[InvoiceDetails]
  inner join Invoice on Invoice.id=[InvoiceDetails].Master_ID
   left outer join Invoice Invoicetemplatemmanufacturing  on Invoicetemplatemmanufacturing.id=invoice.templatemmanuf_ID

  left outer join @tbCustomer  tbCustomer on tbCustomer.id=Invoice.Contact_ID
    and Invoice.EntryType in (1, 2, 3, 4, 5, 10,17,18)

   left outer join  GeneralAttributes    on GeneralAttributes.id=Invoice.TypeTax

  left outer join @tbVender  tbVender on tbVender.id=Invoice.Contact_ID
  and Invoice.EntryType in (6, 7, 8, 11)

  left outer join Branchs on Branchs.id=Invoice.Branch_ID
   left outer join Branchs ToBranch on ToBranch.id=Invoice.ToBranch_ID

  left outer join Currency on Currency.id=Invoice.Currency_ID
  left outer join CostCenters on CostCenters.id=InvoiceDetails.CostCenter_ID
  left outer join CostCenters CostCentersMaster on CostCentersMaster.id=Invoice.CostCenter_ID
  left outer join SalesRep on SalesRep.id=Invoice.SalesRep_ID
   left outer join Store on Store.id=InvoiceDetails.Store_ID
   left outer join Store StoreMaster on StoreMaster.id=Invoice.Stor_ID
    left outer join Store tostore on tostore.id=Invoice.ToStor_ID
     left outer join Driver on Driver.id=Invoice.Driver_ID

  inner join item on item.id=[InvoiceDetails].Item_ID
  inner join ItemsCategories on ItemsCategories.id=item.GroupGuid 
  left outer join item ItemeMaster on item.id=invoice.ItemeMaster_ID


  left outer join Barcode on Barcode.GuidItem=item.guid and Barcode.id=[InvoiceDetails].Uom_ID
  left outer join unititem on unititem.id= Barcode.Unit_ID
   left outer join ItemsBatches on ItemsBatches.id= [InvoiceDetails].Batch_ID
     left outer join Companye on Companye.id=1
 		 left outer join shiftpos  shpos on shpos.id=Invoice.shiftPos
						  left outer join [User]usercreateshiftpos    on usercreateshiftpos.id=shpos.UserCreate  
						    left outer join [User]usercloseshiftpos    on usercloseshiftpos.id=shpos.UserClose  
   LEFT OUTER JOIN
                         dbo.[GeneralAttributes] AS requesttype ON requesttype.id = Invoice.requesttype_ID
						  LEFT OUTER JOIN
                         dbo.[RestaurantTable] AS RestaurantTable ON RestaurantTable.id = Invoice.RestaurantTable_ID
   
	 WHERE	[InvoiceDetails].Master_ID = @ID and ItemsCategories.id= @GroupGuid
  order by [InvoiceDetails].id
	
END;
