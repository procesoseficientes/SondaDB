﻿

CREATE VIEW [acsa].[SWIFT_VIEW_PROVIDER_INVENTORY]
AS
SELECT  DISTINCT   
	(SELECT TOP 1 Z.[NAME_PROVIDER] FROM [acsa].[SWIFT_VIEW_ALL_PROVIDERS] AS Z WHERE Z.CODE_PROVIDER = 
	(SELECT TOP 1 Y.[CODE_PROVIDER] FROM [acsa].[SWIFT_RECEPTION_HEADER] AS Y WHERE Y.[RECEPTION_HEADER] =
	(SELECT TOP 1 W.[HEADER_REFERENCE] FROM [acsa].[SWIFT_TXNS] AS W WHERE W.[TXN_ID] = 
	(SELECT TOP 1 V.[TXN_ID] FROM [acsa].[SWIFT_TXNS_SERIES] AS V WHERE V.[TXN_SERIE] =  A.SERIAL_NUMBER)))) AS NAME_PROVIDER
	,A.SKU AS CODE_SKU
	,ISNULL(A.SERIAL_NUMBER,'N/A') AS SERIAL_NUMBER
	,A.SKU_DESCRIPTION AS DESCRIPTION_SKU
	,A.ON_HAND
	,A.INVENTORY
	,A.BATCH_ID
	,(SELECT COUNT(DISTINCT TAG_COLOR) FROM [acsa].SWIFT_VIEW_TAGS_BY_SKU AS C WHERE C.BATCH_ID = A.BATCH_ID GROUP BY SKU) AS TAGS_BY_BATCH
	,(SELECT COUNT(DISTINCT TAG_COLOR) FROM [acsa].SWIFT_VIEW_TAGS_BY_SKU AS C WHERE C.SERIAL_NUMBER = A.SERIAL_NUMBER GROUP BY SKU) AS TAGS_BY_SERIE
FROM         [acsa].SWIFT_INVENTORY AS A
WHERE A.ON_HAND > 0 AND (SELECT TOP 1 Z.[NAME_PROVIDER] FROM [acsa].[SWIFT_VIEW_ALL_PROVIDERS] AS Z WHERE Z.CODE_PROVIDER = 
	(SELECT TOP 1 Y.[CODE_PROVIDER] FROM [acsa].[SWIFT_RECEPTION_HEADER] AS Y WHERE Y.[RECEPTION_HEADER] =
	(SELECT TOP 1 W.[HEADER_REFERENCE] FROM [acsa].[SWIFT_TXNS] AS W WHERE W.[TXN_ID] = 
	(SELECT TOP 1 V.[TXN_ID] FROM [acsa].[SWIFT_TXNS_SERIES] AS V WHERE V.[TXN_SERIE] =  A.SERIAL_NUMBER)))) IS NOT NULL 



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 126
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 126
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 246
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'DIPROCOM', @level1type = N'VIEW', @level1name = N'SWIFT_VIEW_PROVIDER_INVENTORY';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'DIPROCOM', @level1type = N'VIEW', @level1name = N'SWIFT_VIEW_PROVIDER_INVENTORY';

