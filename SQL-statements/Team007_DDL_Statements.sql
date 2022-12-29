----------------CREATE SCRIPT----------------

---1) CHAINS

USE "OO7"

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chains](
	[ChainID] [int] NOT NULL,
	[ChainName] [varchar](50) NOT NULL,
	[ChainLevel] [varchar](50) NULL,
	[ChainHeadOfficeAddress1] [varchar](500) NOT NULL,
	[ChainHeadOfficeCity] [varchar](50) NOT NULL,
	[ChainHeadOfficeCountry] [varchar](50) NOT NULL,
	[ChainHeadOfficeZipcode] [int] NULL,
	[ChainWebsite] [varchar](50) NOT NULL,
	[ChainHeadOfficePhoneNumber] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ChainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---2) ChainHotel 

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChainHotel](
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[HotelAddress1] [varchar](500) NOT NULL,
	[HotelCity] [varchar](50) NOT NULL,
	[HotelZipCode] [int] NOT NULL,
	[HotelPhoneNumber] [bigint] NOT NULL,
	[HotelEmailAddress] [varchar](500) NOT NULL,
	[HotelFloorCount] [int] NULL,
	[HotelRoomCount] [int] NULL,
 CONSTRAINT [ChainHotelPK] PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC,
	[ChainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChainHotel]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO


--3) Department

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] NOT NULL,
	[DepartmentName] [varchar](50) NOT NULL,
	[DepartmentDesc] [varchar](1500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--4) Investor
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Investor](
	[InvestorID] [int] NOT NULL,
	[InvestorName] [varchar](50) NOT NULL,
	[InvestorStatus] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InvestorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--5) ChainHasInvestor

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChainHasInvestor](
	[InvestorID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
 CONSTRAINT [ChainHasInvestorPK] PRIMARY KEY CLUSTERED 
(
	[InvestorID] ASC,
	[ChainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChainHasInvestor]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[ChainHasInvestor]  WITH CHECK ADD FOREIGN KEY([InvestorID])
REFERENCES [dbo].[Investor] ([InvestorID])
GO

--6) Supplier

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] NOT NULL,
	[SupplierName] [varchar](50) NOT NULL,
	[SupplierType] [varchar](50) NOT NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Supplier]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Supplier]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO


--7) Employee
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[EmployeeRole] [varchar](100) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Gender] [varchar](15) NOT NULL,
	[PhoneNumber] [bigint] NOT NULL,
	[EmailAddress] [varchar](500) NOT NULL,
	[PassportNo] [varchar](50) NOT NULL,
	[ZipCode] [int] NULL,
	[City] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CheckAge] CHECK  ((datediff(year,[DateOfBirth],getdate())>(18)))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CheckAge]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[ComputeAge]
ON [dbo].[Employee] 
	AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	UPDATE Employee
	SET Age = (DATEDIFF(YEAR,DateOfBirth, GETDATE()))
	FROM Employee;
END;
GO
ALTER TABLE [dbo].[Employee] ENABLE TRIGGER [ComputeAge]
GO

--8) Membership

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membership](
	[MembershipID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[MembershipStartDate] [datetime] NOT NULL,
	[MembershipEndDate] [datetime] NOT NULL,
	[MembershipPoints] [int] NOT NULL,
	[MembershipStatus] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MembershipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Membership]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Membership]  WITH CHECK ADD  CONSTRAINT [CheckStartandEndDateMemberShip] CHECK  (([MembershipStartDate]<[MembershipEndDate]))
GO
ALTER TABLE [dbo].[Membership] CHECK CONSTRAINT [CheckStartandEndDateMemberShip]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[ComputeMembershipStatus]
ON [dbo].[Membership] 
	AFTER INSERT
AS 
BEGIN
	UPDATE Membership
	SET MembershipStatus = CASE WHEN (MembershipPoints <= 500) THEN 'Silver'
		WHEN (MembershipPoints > 500 AND MembershipPoints <= 750) THEN 'Gold'
		WHEN (MembershipPoints > 750 AND MembershipPoints <= 1000) THEN 'Diamond'
		ELSE 'Platinum'
		END 
	FROM Membership;
END;
GO
ALTER TABLE [dbo].[Membership] ENABLE TRIGGER [ComputeMembershipStatus]
GO

--9) Customer

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Gender] [varchar](15) NULL,
	[PhoneNumber] [bigint] NULL,
	[EmailAddress] [varchar](500) NULL,
	[PassportNo] [varchar](50) NULL,
	[ZipCode] [int] NULL,
	[City] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[isMember] [bit] NULL,
	[MembershipID] [int] NULL,
	[DATEOFBIRTH] [date] NULL,
	[CUSTAGE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [CheckCustomerAge] CHECK  ((datediff(year,[DATEOFBIRTH],getdate())>(18)))
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CheckCustomerAge]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[ComputeCustAge]
ON [dbo].[Customer] 
	AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	UPDATE Customer
	SET CustAge = (DATEDIFF(YEAR, DateOfBirth, GETDATE()))
	FROM Customer;
END;
GO
ALTER TABLE [dbo].[Customer] ENABLE TRIGGER [ComputeCustAge]
GO

--10) EventReservation
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventReservation](
	[EventID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[EventDate] [date] NOT NULL,
	[NoOfGuests] [int] NULL,
	[ifCatering] [bit] NULL,
	[EventType] [varchar](100) NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[SpecialRequest] [varchar](1500) NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventReservation]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[EventReservation]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[EventReservation]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO
ALTER TABLE [dbo].[EventReservation]  WITH CHECK ADD  CONSTRAINT [CheckGuestNumber] CHECK  (([NoOfGuests]<(1000)))
GO
ALTER TABLE [dbo].[EventReservation] CHECK CONSTRAINT [CheckGuestNumber]
GO

--11) EventInvoice
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventInvoice](
	[EventInvoiceID] [int] NOT NULL,
	[EventID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Amount] [money] NULL,
 CONSTRAINT [PK_P] PRIMARY KEY CLUSTERED 
(
	[EventInvoiceID] ASC,
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventInvoice]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[EventInvoice]  WITH CHECK ADD FOREIGN KEY([EventID])
REFERENCES [dbo].[EventReservation] ([EventID])
GO

--12) Amenity
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Amenity](
	[AmenityID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[AmenityName] [varchar](50) NOT NULL,
	[AmenityCost] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AmenityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Amenity]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Amenity]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO
ALTER TABLE [dbo].[Amenity]  WITH CHECK ADD  CONSTRAINT [CheckAmenityCharge] CHECK  (([AmenityCost]>(0)))
GO
ALTER TABLE [dbo].[Amenity] CHECK CONSTRAINT [CheckAmenityCharge]
GO

--13) EVENTHASAMENITY
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventHasAmenity](
	[EventID] [int] NOT NULL,
	[AmenityID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventHasAmenity]  WITH CHECK ADD FOREIGN KEY([AmenityID])
REFERENCES [dbo].[Amenity] ([AmenityID])
GO
ALTER TABLE [dbo].[EventHasAmenity]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[EventHasAmenity]  WITH CHECK ADD FOREIGN KEY([EventID])
REFERENCES [dbo].[EventReservation] ([EventID])
GO

--14) Room
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[RoomCapacity] [smallint] NOT NULL,
	[RoomPrice] [money] NOT NULL,
	[RoomNumber] [varchar](50) NOT NULL,
	[RoomType] [varchar](50) NULL,
	[isPetFriendly] [bit] NULL,
	[ChainID] [int] NULL,
 CONSTRAINT [Room_PK1] PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC,
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [CheckRoomCharge] CHECK  (([RoomPrice]>(0)))
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [CheckRoomCharge]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateChainID]
ON [dbo].[Room] 
	AFTER INSERT
AS 
BEGIN
	UPDATE Room
	SET Room.ChainID = C.ChainId
	FROM 
	(SELECT * FROM ChainHotel) C
	WHERE 
	Room.HotelID = C.HotelID
END;
GO
ALTER TABLE [dbo].[Room] ENABLE TRIGGER [UpdateChainID]
GO

--14) CustomerFeedback

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerFeedback](
	[CustomerID] [int] NOT NULL,
	[DatePublished] [date] NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[Comments] [varchar](5000) NULL,
	[ReservationID] [int] NOT NULL,
	[Ratings] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerFeedback]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[CustomerFeedback]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerFeedback]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO

--15) Restaurant

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[RestaurantID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[RestaurantName] [varchar](50) NOT NULL,
	[RestaurantDescription] [varchar](1500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RestaurantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO

--16) RestaurantReservation

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantReservation](
	[ReservationID] [int] NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ReservedForDate] [date] NULL,
	[ReservedForTime] [time](7) NULL,
	[ReservedOnDate] [datetime] NULL,
	[NumberOfGuests] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RestaurantReservation]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[RestaurantReservation]  WITH CHECK ADD FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurant] ([RestaurantID])
GO


--17) ReservationHasAmenity
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationHasAmenity](
	[ReservationID] [int] NOT NULL,
	[AmenityID] [int] NULL,
	[HotelID] [int] NOT NULL,
	[ChainID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReservationHasAmenity]  WITH CHECK ADD FOREIGN KEY([AmenityID])
REFERENCES [dbo].[Amenity] ([AmenityID])
GO
ALTER TABLE [dbo].[ReservationHasAmenity]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[ReservationHasAmenity]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationHasAmenity]  WITH CHECK ADD FOREIGN KEY([HotelID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO


--18) Room

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[RoomCapacity] [smallint] NOT NULL,
	[RoomPrice] [money] NOT NULL,
	[RoomNumber] [varchar](50) NOT NULL,
	[RoomType] [varchar](50) NULL,
	[isPetFriendly] [bit] NULL,
	[ChainID] [int] NULL,
 CONSTRAINT [Room_PK1] PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC,
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [CheckRoomCharge] CHECK  (([RoomPrice]>(0)))
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [CheckRoomCharge]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[UpdateChainID]
ON [dbo].[Room] 
	AFTER INSERT
AS 
BEGIN
	UPDATE Room
	SET Room.ChainID = C.ChainId
	FROM 
	(SELECT * FROM ChainHotel) C
	WHERE 
	Room.HotelID = C.HotelID
END;
GO
ALTER TABLE [dbo].[Room] ENABLE TRIGGER [UpdateChainID]
GO

--19) RoomReservation
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomReservation](
	[ReservationID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[CheckInDate] [date] NOT NULL,
	[CheckOutDate] [date] NOT NULL,
	[isBookedOnline] [bit] NULL,
	[NoOfGuests] [int] NOT NULL,
	[roomqty] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RoomReservation]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[RoomReservation]  WITH CHECK ADD  CONSTRAINT [CheckStartandEndDate] CHECK  (([CheckInDate]<[CheckOutDate]))
GO
ALTER TABLE [dbo].[RoomReservation] CHECK CONSTRAINT [CheckStartandEndDate]
GO


-- 20) RoomsBooked

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomsBooked](
	[ReservationID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ChainID] [int] NULL,
	[HOTELID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RoomsBooked]  WITH CHECK ADD FOREIGN KEY([ChainID])
REFERENCES [dbo].[Chains] ([ChainID])
GO
ALTER TABLE [dbo].[RoomsBooked]  WITH CHECK ADD FOREIGN KEY([HOTELID])
REFERENCES [dbo].[ChainHotel] ([HotelID])
GO
ALTER TABLE [dbo].[RoomsBooked]  WITH CHECK ADD FOREIGN KEY([ReservationID])
REFERENCES [dbo].[RoomReservation] ([ReservationID])
GO


--21) Invoice

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] NOT NULL,
	[ReservationID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[RoomCharge] [money] NULL,
	[RestaurantCharges] [money] NULL,
	[BarCharges] [money] NULL,
	[ifLateCheckout] [bit] NULL,
	[PaymentDate] [date] NULL,
	[PaymentMode] [varchar](50) NULL,
	[ExpirationDate] [date] NULL,
	[CVV] [smallint] NULL,
	[FinalAmount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD FOREIGN KEY([ReservationID])
REFERENCES [dbo].[RoomReservation] ([ReservationID])
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InvoiceFinalAmount]
ON [dbo].[Invoice] 
	AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	UPDATE Invoice
	SET Invoice.FinalAmount = case when ifLateCheckout = 1 then RoomCharge*0.1 + RoomCharge + RestaurantCharges + BarCharges else
								RoomCharge + RestaurantCharges + BarCharges	END							
END;
GO
ALTER TABLE [dbo].[Invoice] ENABLE TRIGGER [InvoiceFinalAmount]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[RoomChargeNoOfRooms_B1]
ON [dbo].[Invoice] 
	AFTER INSERT
AS 
BEGIN
	UPDATE Invoice
	SET Invoice.RoomCharge = C.TotalCharge
	FROM 
	(SELECT CustomerID,ReservationID, SUM(RoomPrice) AS TotalCharge FROM RoomsBooked a
	LEFT JOIN
	Room b
	on a.RoomID = b.RoomID
	GROUP BY CustomerID,ReservationID)C
	WHERE Invoice.CustomerID = C.CustomerID AND Invoice.ReservationID = C.ReservationID;
END;
GO
ALTER TABLE [dbo].[Invoice] ENABLE TRIGGER [RoomChargeNoOfRooms_B1]
GO



-------VIEWS-----
-- 1) Creating a view to keep track of revenue generated by or different segments
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[CustomerRevenueDetails] AS
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

-- 2) Creating a view to keep track of top chains wrt events happening.
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[TopEventChainsDetails] AS
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
WHERE RK = 1