Select *
from Sqlportfolio.dbo.Nashvillehousing

---Converting SALEDATE

Select Saledate
from Sqlportfolio.dbo.Nashvillehousing

Select saledate, CONVERT(Date,Saledate)
from Sqlportfolio.dbo.Nashvillehousing



ALTER TABLE Nashvillehousing
Add saledateconverted Date;

Update Nashvillehousing
Set saledateconverted = CONVERT(Date,Saledate)

Select saledateconverted, CONVERT(Date,Saledate)
from Sqlportfolio.dbo.Nashvillehousing


---Populate property address
Select PropertyAddress
from Sqlportfolio.dbo.Nashvillehousing

----view nullvalues
Select PropertyAddress
from Sqlportfolio.dbo.Nashvillehousing
where PropertyAddress is NULL

Select a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from Sqlportfolio.dbo.Nashvillehousing a
JOIN Sqlportfolio.dbo.Nashvillehousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID] <> b.[UniqueID] 
	 where a.propertyAddress is null

	 UPDATE a
	 SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
	 From Sqlportfolio.dbo.Nashvillehousing a
JOIN Sqlportfolio.dbo.Nashvillehousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID] <> b.[UniqueID] 
	 where a.propertyAddress is null


	 Select a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from Sqlportfolio.dbo.Nashvillehousing a
JOIN Sqlportfolio.dbo.Nashvillehousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID] <> b.[UniqueID] 
	 where a.propertyAddress is null

	 ----Breaking Adddress into Address, city and state

	 Select PropertyAddress
from Sqlportfolio.dbo.Nashvillehousing

SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1) as Address
from Sqlportfolio.dbo.Nashvillehousing


SELECT
SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1) as Address
 ,SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from Sqlportfolio.dbo.Nashvillehousing



ALTER TABLE Nashvillehousing
Add PropertySplitAddress Nvarchar(255);

Update Nashvillehousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',', PropertyAddress) -1) 


ALTER TABLE Nashvillehousing
Add PropertySplitcity Nvarchar(255);

Update Nashvillehousing
Set PropertySplitcity  = SUBSTRING(PropertyAddress,CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


Select *
from Sqlportfolio.dbo.Nashvillehousing

Select owneraddress
from Sqlportfolio.dbo.Nashvillehousing


Select
PARSENAME(REPLACE(owneraddress, ',', '.'),1)
from Sqlportfolio.dbo.Nashvillehousing


Select
PARSENAME(REPLACE(owneraddress, ',', '.'),3)
,PARSENAME(REPLACE(owneraddress, ',', '.'),2)
 ,PARSENAME(REPLACE(owneraddress, ',', '.'),1)
from Sqlportfolio.dbo.Nashvillehousing


ALTER TABLE Nashvillehousing
Add OwnwerSplitAddress Nvarchar(255);

Update Nashvillehousing
Set OwnwerSplitAddress = PARSENAME(REPLACE(owneraddress, ',', '.'),3)


ALTER TABLE Nashvillehousing
Add OwnwerSplitCity Nvarchar(255);

Update Nashvillehousing
Set OwnwerSplitCity = PARSENAME(REPLACE(owneraddress, ',', '.'),2)



ALTER TABLE Nashvillehousing
Add OwnwerSplitstate  Nvarchar(255);

Update Nashvillehousing
Set OwnwerSplitstate = PARSENAME(REPLACE(owneraddress, ',', '.'),1)


Select *
from Sqlportfolio.dbo.Nashvillehousing



------changing y to yes and N to No in solad as vacant
Select Distinct(SoldasVacant)
from Sqlportfolio.dbo.Nashvillehousing

Select Distinct(SoldasVacant), count(SoldasVacant)
from Sqlportfolio.dbo.Nashvillehousing
Group by SoldasVacant
Order by 2

Select SoldasVacant
 , CASE when SoldasVacant = 'Y' THEN 'yes'
 When SoldasVacant = 'N' THEN 'No'
 ELSE SoldasVacant
 END
from Sqlportfolio.dbo.Nashvillehousing

UPDATE Nashvillehousing
SET SoldasVacant = CASE when SoldasVacant = 'Y' THEN 'yes'
 When SoldasVacant = 'N' THEN 'No'
 ELSE SoldasVacant
 END

 Select Distinct(SoldasVacant), count(SoldasVacant)
from Sqlportfolio.dbo.Nashvillehousing
Group by SoldasVacant
Order by 2


-----REMOVING DUPLICATES
WITH RowNUMCTE AS(
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
				UniqueID
				) row_num
from Sqlportfolio.dbo.Nashvillehousing
---order by ParcelID
)
Select *
From RowNumCTE
where row_num > 1
Order by PropertyAddress

WITH RowNumCTE AS(
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
				UniqueID
				) row_num
from Sqlportfolio.dbo.Nashvillehousing
---order by ParcelID
)
Select *
From RowNumCTE
where row_num>1
order by PropertyAddress


WITH RowNumCTE AS(
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
				UniqueID
				) row_num
from Sqlportfolio.dbo.Nashvillehousing
---order by ParcelID
)
DELETE
From RowNumCTE
where row_num>1


---DELETEING UNUSED COLUMNS

Select *
from Sqlportfolio.dbo.Nashvillehousing

ALTER TABLE Sqlportfolio.dbo.Nashvillehousing
DROP COLUMN Owneraddress,TaxDistrict,SaleDate,PropertyAddress

