select * from CustomerDataset;

--retrieve the total number of customers from each region.
SELECT 
  Region, 
  COUNT(CustomerID) AS Total_Customers
FROM 
  CustomerDataset
GROUP BY 
  Region
ORDER BY 
  Total_Customers DESC;

--find the most popular subscription type by the number of customers.
SELECT TOP 1 
  subscriptionType, 
  COUNT(customerId) AS num_customers
FROM 
  CustomerDataset
GROUP BY 
  subscriptionType
ORDER BY 
  num_customers DESC;

--find customers who canceled their subscription within 6 months.
SELECT 
  CustomerName,
  canceled,
  SubscriptionEnd
FROM 
  CustomerDataset
WHERE 
  canceled = 'TRUE'
  AND SubscriptionEnd >= DATEADD(month, -6, GETDATE())
ORDER BY 
  SubscriptionEnd DESC;

--calculate the average subscription duration for all customers.
SELECT 
  AVG(Subscription_duration) AS avg_subscription_duration
FROM 
  CustomerDataset
WHERE 
  canceled = 'TRUE';

--find customers with subscriptions longer than 12 months.
  SELECT 
    CustomerID,
    CustomerName,
    Subscription_Duration
  FROM 
    CustomerDataset
		WHERE Subscription_Duration > 365 AND Canceled = 'FALSE'
	ORDER BY 
		CustomerID,
		CustomerName,
		Subscription_Duration;

--calculate total revenue by subscription type.
SELECT 
	SubscriptionType,
	SUM(Revenue) AS total_revenue
FROM 
	CustomerDataset
GROUP BY 
	SubscriptionType
ORDER BY 
  total_revenue DESC;

--find the top 3 regions by subscription cancellations.

SELECT TOP 3
  Region,
  COUNT(CustomerID) AS cancellation_count
FROM 
  CustomerDataset
WHERE 
  Canceled = 'TRUE'
GROUP BY 
  Region
ORDER BY 
  cancellation_count DESC;

--find the total number of active and canceled subscriptions.
SELECT 
	Canceled,
	COUNT(CustomerID) AS subscription_count
FROM 
	CustomerDataset
GROUP BY 
	Canceled;
---------
SELECT 
	SUM(CASE WHEN Canceled = 'TRUE' THEN 1 ELSE 0 END) AS total_canceled,
	SUM(CASE WHEN Canceled = 'FALSE' THEN 1 ELSE 0 END) AS total_active
FROM 
	CustomerDataset;
