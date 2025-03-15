CREATE TABLE [currency] (
  [id] int,
  [description] varchar
);

CREATE TABLE [order_status] (
  [id] int,
  [description] varchar
);

CREATE TABLE [date_lookup] (
  [day] date,
  [first_day_of_month] bool,
  [first_day_of_week] bool,
  [date_key(date)] int
);

CREATE TABLE [customers] (
  [id] int,
  [customer_name] varchar
);

CREATE TABLE [country] (
  [id] int,
  [country] varchar,
  [city] varchar,
  [sales_channel] Type
);

CREATE TABLE [product] (
  [product_id] int,
  [category] varchar,
  [subcategory] varchar,
  [product_family] Type,
  [key_product] Type,
  [sku] Type,
  [description] Type,
  [grade] Type
);

CREATE TABLE [country] (
  [serial] int,
  [bin_id] int,
  [sales_order] int,
  [quantity] int,
  [date_key (sales_date)] int,
  [status_id] int,
  [price_sold_per_device] int,
  [sold_currency] int,
  [customer_id] int,
  [cost_per_device] int,
  [cost_currency] int,
  [country_id] int,
  [product_id (sku)] int,
  CONSTRAINT [FK_country.date_key (sales_date)]
    FOREIGN KEY ([date_key (sales_date)])
      REFERENCES [date_lookup]([date_key(date)]),
  CONSTRAINT [FK_country.customer_id]
    FOREIGN KEY ([customer_id])
      REFERENCES [customers]([id]),
  CONSTRAINT [FK_country.country_id]
    FOREIGN KEY ([country_id])
      REFERENCES [country]([id]),
  CONSTRAINT [FK_country.product_id (sku)]
    FOREIGN KEY ([product_id (sku)])
      REFERENCES [product]([product_id]),
  CONSTRAINT [FK_country.status_id]
    FOREIGN KEY ([status_id])
      REFERENCES [order_status]([id]),
  CONSTRAINT [FK_country.cost_currency]
    FOREIGN KEY ([cost_currency])
      REFERENCES [currency]([id]),
  CONSTRAINT [FK_country.sold_currency]
    FOREIGN KEY ([sold_currency])
      REFERENCES [currency]([id])
);

CREATE TABLE [costs] (
  [date] date,
  [instance_type] varchar,
  [cost] decimal,
  CONSTRAINT [FK_costs.date]
    FOREIGN KEY ([date])
      REFERENCES [date_lookup]([first_day_of_month])
);

CREATE TABLE [currency_converter] (
  [date] date,
  [conversion] varchar,
  [conversion_value] decimal,
  CONSTRAINT [FK_currency_converter.date]
    FOREIGN KEY ([date])
      REFERENCES [date_lookup]([first_day_of_week])
);

