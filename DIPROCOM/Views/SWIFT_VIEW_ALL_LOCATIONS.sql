


CREATE VIEW [DIPROCOM].[SWIFT_VIEW_ALL_LOCATIONS]
AS
SELECT
	DIPROCOM.SWIFT_LOCATIONS.LOCATION
	, DIPROCOM.SWIFT_LOCATIONS.CODE_LOCATION
	, DIPROCOM.SWIFT_CLASSIFICATION.NAME_CLASSIFICATION AS CLASSIFICATION_LOCATION
	, DIPROCOM.SWIFT_LOCATIONS.HALL_LOCATION
	, DIPROCOM.SWIFT_LOCATIONS.ALLOW_PICKING
	, DIPROCOM.SWIFT_WAREHOUSES.DESCRIPTION_WAREHOUSE
	, DIPROCOM.SWIFT_LOCATIONS.CODE_WAREHOUSE
	, [BARCODE_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[DESCRIPTION_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[RACK_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[COLUMN_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[LEVEL_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[SQUARE_METER_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[FLOOR_LOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[ALLOW_STORAGE]
	, DIPROCOM.SWIFT_LOCATIONS.[ALLOW_RELOCATION]
	, DIPROCOM.SWIFT_LOCATIONS.[STATUS_LOCATION]
	, DIPROCOM.SWIFT_CLASSIFICATION.CLASSIFICATION AS CLASSIFICATION_ID
FROM DIPROCOM.SWIFT_LOCATIONS 
	LEFT OUTER JOIN DIPROCOM.SWIFT_CLASSIFICATION ON DIPROCOM.SWIFT_LOCATIONS.CLASSIFICATION_LOCATION = DIPROCOM.SWIFT_CLASSIFICATION.CLASSIFICATION 
	LEFT OUTER JOIN DIPROCOM.SWIFT_WAREHOUSES ON DIPROCOM.SWIFT_LOCATIONS.CODE_WAREHOUSE = DIPROCOM.SWIFT_WAREHOUSES.CODE_WAREHOUSE









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
         Begin Table = "SWIFT_LOCATIONS (DIPROCOM)"
            Begin Extent = 
               Top = 75
               Left = 62
               Bottom = 239
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "SWIFT_WAREHOUSES (DIPROCOM)"
            Begin Extent = 
               Top = 5
               Left = 497
               Bottom = 125
               Right = 724
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SWIFT_CLASSIFICATION (DIPROCOM)"
            Begin Extent = 
               Top = 170
               Left = 473
               Bottom = 290
               Right = 713
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
', @level0type = N'SCHEMA', @level0name = N'DIPROCOM', @level1type = N'VIEW', @level1name = N'SWIFT_VIEW_ALL_LOCATIONS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'DIPROCOM', @level1type = N'VIEW', @level1name = N'SWIFT_VIEW_ALL_LOCATIONS';

