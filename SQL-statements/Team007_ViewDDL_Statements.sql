SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- dbo.CustomerRevenueDetails source

CREATE View [dbo].[CustomerRevenueDetails] AS
SELECT SUM(CASE WHEN ISMEMBER = 1 THEN FINALAMOUNT END) AS Member_Revenue,
SUM(CASE WHEN ISMEMBER = 0 THEN FINALAMOUNT END) AS Non_Member_Revenue,
SUM(CASE WHEN ISBOOKEDONLINE = 0 THEN FINALAMOUNT END) AS Offline_revenue,
SUM(CASE WHEN ISBOOKEDONLINE = 1 THEN FINALAMOUNT END) AS online_revenue,
SUM(CASE WHEN MembershipSTATUS = 'Gold' THEN FinalAmount ELSE 0 END) AS GOLD_revenue,
SUM(CASE WHEN MembershipSTATUS = 'Diamond' THEN FinalAmount ELSE 0 END) AS Diamond_revenue,
SUM(CASE WHEN MembershipSTATUS = 'Silver' THEN FinalAmount ELSE 0 END) AS Silver_revenue,
SUM(CASE WHEN MembershipSTATUS = 'Platinum' THEN FinalAmount ELSE 0 END) AS Platinum_revenue
 FROM RoomReservation
LEFT JOIN
Customer
ON RoomReservation.CustomerID = Customer.CustomerID
LEFT JOIN 
Membership 
ON Customer.CustomerID = Membership.CustomerID
LEFT JOIN
Invoice
ON RoomReservation.ReservationID = Invoice.ReservationID;
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- dbo.TopEventChainsDetails source

CREATE View [dbo].[TopEventChainsDetails] AS
SELECT  ChainID,ChainName,ChainLevel,Eventtype,[Total Revenue],[Total Events] FROM 
(SELECT Chains.ChainID,ChainName,ChainLevel,Eventtype,SUM(AMOUNT) as [Total Revenue], count(1) as [Total Events],
DENSE_RANK() OVER(PARTITION by Eventtype order by SUM(AMOUNT) desc ) AS RK FROM EventReservation
LEFT JOIN 
EventInvoice
ON EventReservation.EventID = EventInvoice.EventID
LEFT JOIN
Chains
ON Chains.ChainID = EventReservation.ChainID
GROUP BY Chains.ChainID,Eventtype,ChainName,ChainLevel)c
WHERE RK = 1;

GO
