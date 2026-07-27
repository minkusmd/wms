unit SWNCustomersTypesUnit;

interface

type

  TCustomerFilters = (cfCustomers,cfFirms,cfDiler,cfFranchises,cfVendors,cfSecuredFirms,cfColaboratori, cfStocks);
  TCustomerFiltersSet = set of TCustomerFilters;

const
  cCustomerAllFilters = [cfCustomers,cfFirms,cfDiler,cfFranchises,cfVendors,cfSecuredFirms,cfColaboratori, cfStocks];


implementation

end.
