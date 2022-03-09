CREATE VIEW [DIPROCOM].[ERP_VIEW_ORDER_SERIE_DETAIL]
as 
select *from openquery (ERPSERVER,'SELECT     [BD_prueba_viscosa].dbo.OSRN.SysNumber, [BD_prueba_viscosa].dbo.OSRN.MnfSerial, [BD_prueba_viscosa].dbo.OSRN.ItemCode
                                                    FROM          [BD_prueba_viscosa].dbo.PDN1 INNER JOIN
                                                                           [BD_prueba_viscosa].dbo.OPDN ON [BD_prueba_viscosa].dbo.PDN1.DocEntry = [BD_prueba_viscosa].dbo.OPDN.DocEntry INNER JOIN
                                                                           [BD_prueba_viscosa].dbo.OITL ON [BD_prueba_viscosa].dbo.PDN1.ItemCode = [BD_prueba_viscosa].dbo.OITL.ItemCode AND [BD_prueba_viscosa].dbo.PDN1.DocEntry = [BD_prueba_viscosa].dbo.OITL.DocEntry AND 
                                                                           [BD_prueba_viscosa].dbo.PDN1.LineNum = [BD_prueba_viscosa].dbo.OITL.DocLine INNER JOIN
                                                                           [BD_prueba_viscosa].dbo.ITL1 ON [BD_prueba_viscosa].dbo.OITL.LogEntry = [BD_prueba_viscosa].dbo.ITL1.LogEntry INNER JOIN
                                                                           [BD_prueba_viscosa].dbo.OSRN ON [BD_prueba_viscosa].dbo.ITL1.MdAbsEntry = [BD_prueba_viscosa].dbo.OSRN.AbsEntry
                                                    WHERE      ([BD_prueba_viscosa].dbo.OITL.DocType = 20) AND ([BD_prueba_viscosa].dbo.OITL.ManagedBy = 10000045) ')