import 'dart:convert';

final routeFilters = {
  'routeId': '123',
  'routeFilters': jsonEncode([
    'additionalMaterials.id',
    'additionalMaterials.quantity',
    'additionalMaterials.transport.id',
    'additionalMaterials.transport.key',
    'additionalMaterials.sizeAlias.id',
    'additionalMaterials.sizeAlias.key',
    'driverPendingBalances.amount',
    'driverPendingBalances.description',
    'driverPendingBalances.driver.id',
    'driverPendingBalances.id',
    'manifests.id',
    'manifests.size1',
    'manifests.size1Alias.*',
    'manifests.size2',
    'manifests.size2Alias.*',
    'manifests.size3',
    'manifests.size3Alias.*',
    'manifests.transport.date',
    'manifests.transport.id',
    'manifests.transport.key',
    'manifests.udfs.id',
    'manifests.udfs.key',
    'manifests.udfs.value',
    'size1AliasConfig.*',
    'size2AliasConfig.*',
    'size3AliasConfig.*',
    'totalStops',
    'actualArrival',
    'actualDeparture',
    'actualDistance',
    'id',
    'lastStopIsDestination',
    'plannedArrival',
    'plannedComplete',
    'plannedDeparture',
    'status',
    'plannedSize1',
    'plannedSize2',
    'plannedSize3',
    'plannedPickupSize1',
    'plannedPickupSize2',
    'plannedPickupSize3',
    'description',
    'destLatitude',
    'destLongitude',
    'organization.id',
    'organization.key',
    'origLatitude',
    'origLongitude',
    'plannedArrival',
    'plannedComplete',
    'plannedDistance',
    'plannedStart',
    'date',
    'key',
    'helperAssignments.helper.id',
    'helperAssignments.helper.login',
    'helperAssignments.helper.name',
    'helperAssignments.helper.organization.id',
    'helperAssignments.helper.organization.key',
    'helperAssignments.id',
    'proactiveRouteOptConfig.*',
    'destination.id',
    'destination.description',
    'destination.district',
    'destination.phone1',
    'destination.phone2',
    'destination.addressLine1',
    'destination.addressLine2',
    'destination.zipCode',
    'destination.city',
    'destination.state',
    'destination.country',
    'destination.id',
    'destination.key',
    'destination.latitude',
    'destination.longitude',
    'destination.description',
    'destination.deliveryInstructions',
    'destination.locationType.id',
    'destination.locationType.key',
    'destination.locationType.description',
    'destination.locationType.showOnMobileCreate',
    'destination.accountType.id',
    'destination.accountType.key',
    'destination.accountType.description',
    'destination.accountType.color',
    'destination.email',
    'destination.deliveryRadius',
    'origin.id',
    'origin.description',
    'origin.district',
    'origin.phone1',
    'origin.phone2',
    'origin.addressLine1',
    'origin.addressLine2',
    'origin.zipCode',
    'origin.city',
    'origin.state',
    'origin.country',
    'origin.id',
    'origin.key',
    'origin.latitude',
    'origin.longitude',
    'origin.description',
    'origin.deliveryInstructions',
    'origin.locationType.id',
    'origin.locationType.key',
    'origin.locationType.description',
    'origin.locationType.showOnMobileCreate',
    'origin.accountType.id',
    'origin.accountType.key',
    'origin.accountType.description',
    'origin.accountType.color',
    'origin.email',
    'origin.deliveryRadius',
    'additionalMaterials.sku.id',
    'additionalMaterials.sku.key',
    'additionalMaterials.sku.description',
    'additionalMaterials.sku.brand',
    'additionalMaterials.sku.organization.id',
    'additionalMaterials.sku.organization.key',
    'additionalMaterials.sku.baseUnit.*',
    'additionalMaterials.sku.secondaryUnit.*',
    'additionalMaterials.sku.tertiaryUnit.*',
    'additionalMaterials.sku.secondaryQty',
    'additionalMaterials.sku.secondaryCompound',
    'additionalMaterials.sku.secondaryCompoundQty',
    'additionalMaterials.sku.skuType.id',
    'additionalMaterials.sku.skuType.key',
    'additionalMaterials.sku.skuGroup.*',
    'additionalMaterials.sku.udfs.key',
    'additionalMaterials.sku.udfs.value',
    'manifests.sku.id',
    'manifests.sku.key',
    'manifests.sku.description',
    'manifests.sku.brand',
    'manifests.sku.organization.id',
    'manifests.sku.organization.key',
    'manifests.sku.baseUnit.*',
    'manifests.sku.secondaryUnit.*',
    'manifests.sku.tertiaryUnit.*',
    'manifests.sku.secondaryQty',
    'manifests.sku.secondaryCompound',
    'manifests.sku.secondaryCompoundQty',
    'manifests.sku.skuType.id',
    'manifests.sku.skuType.key',
    'manifests.sku.skuGroup.*',
    'manifests.sku.udfs.key',
    'manifests.sku.udfs.value',
    'notLoadedSkus.id',
    'notLoadedSkus.sku.id',
    'notLoadedSkus.sku.key',
    'notLoadedSkus.sku.description',
    'notLoadedSkus.transport.id',
    'notLoadedSkus.quantity',
    'notLoadedSkus.sizeAlias.id',
    'notLoadedSkus.sizeAlias.key',
    'notLoadedSkus.sizeAlias.description',
    'notLoadedSkus.sizeAlias.icon',
    'notLoadedSkus.sizeAlias.preferredSize',
    'additionalMaterials.sizeAlias.preferredSize'
  ]),
  'stopFilters': jsonEncode([
    'actualArrival',
    'actualDeparture',
    'actualSequenceNum',
    'actualService',
    'cancelCode.id',
    'id',
    'instructions',
    'key',
    'plannedArrival',
    'plannedDeparture',
    'latitude',
    'longitude',
    'projectedArrival',
    'projectedDeparture',
    'redeliveryStop.id',
    'stopDocuments.documentDescription',
    'stopDocuments.documentNumber',
    'stopDocuments.id',
    'stopDocuments.order.id',
    'stopType.description',
    'stopType.id',
    'stopType.key',
    'stopType.locationRequired',
    'stopType.type',
    'transport.date',
    'transport.id',
    'transport.key',
    'transport.*',
    'undeliverableCode.id',
    'actualSize1',
    'actualSize2',
    'actualSize3',
    'plannedSize1',
    'plannedSize2',
    'plannedSize3',
    'actualPickupSize1',
    'actualPickupSize2',
    'actualPickupSize3',
    'damagedSize1',
    'damagedSize2',
    'damagedSize3',
    'plannedPickupSize1',
    'plannedPickupSize2',
    'plannedPickupSize3',
    'size1AliasConfig.*',
    'size2AliasConfig.*',
    'size3AliasConfig.*',
    'stopEtaListeners.id',
    'stopEtaListeners.actualArrival',
    'stopEtaListeners.actualDeparture',
    'stopEtaListeners.actualCancel',
    'stopEtaListeners.actualService',
    'stopEtaListeners.plannedArrival',
    'stopEtaListeners.cancelCode.id',
    'stopEtaListeners.undeliverableCode.id',
    'stopEtaListeners.projectedArrival',
    'stopEtaListeners.location.id',
    'stopEtaListeners.location.key',
    'stopEtaListeners.route.id',
    'stopEtaListeners.route.driverAssignments.id',
    'stopEtaListeners.route.driverAssignments.driver.id',
    'stopEtaListeners.route.driverAssignments.driver.name',
    'stopEtaListeners.route.organization.id',
    'stopEtaListeners.route.organization.description',
    'bulkArriveGroup',
    'plannedSequenceNum'
  ]),
  'locationPendingPaymentFilters': jsonEncode([
    'amount',
    'documentKey',
    'dueDate',
    'invoice',
    'remark',
    'saleDate',
    'amountPayed',
    'id',
    'location.id',
    'location.description',
    'location.district',
    'location.phone1',
    'location.phone2',
    'location.addressLine1',
    'location.addressLine2',
    'location.zipCode',
    'location.city',
    'location.state',
    'location.country',
    'location.id',
    'location.key',
    'location.latitude',
    'location.longitude',
    'location.description',
    'location.deliveryInstructions',
    'location.locationType.id',
    'location.locationType.key',
    'location.locationType.description',
    'location.locationType.showOnMobileCreate',
    'location.accountType.id',
    'location.accountType.key',
    'location.accountType.description',
    'location.accountType.color',
    'location.email',
    'location.deliveryRadius',
    'location.appliedTax',
    'location.creditLimit'
  ]),
  'consignedSkuFilters': jsonEncode([
    'actualSize1',
    'actualSize2',
    'actualSize3',
    'amount',
    'amountReceived',
    'dateConsigned',
    'id',
    'newRouteConsignedSku',
    'plannedSize1',
    'plannedSize2',
    'plannedSize3',
    'size1Alias.*',
    'size2Alias.*',
    'size3Alias.*',
    'location.id',
    'location.description',
    'location.district',
    'location.phone1',
    'location.phone2',
    'location.addressLine1',
    'location.addressLine2',
    'location.zipCode',
    'location.city',
    'location.state',
    'location.country',
    'location.id',
    'location.key',
    'location.latitude',
    'location.longitude',
    'location.description',
    'location.deliveryInstructions',
    'location.locationType.id',
    'location.locationType.key',
    'location.locationType.description',
    'location.locationType.showOnMobileCreate',
    'location.accountType.id',
    'location.accountType.key',
    'location.accountType.description',
    'location.accountType.color',
    'location.email',
    'location.deliveryRadius',
    'location.appliedTax',
    'location.creditLimit',
    'sku.id',
    'sku.key',
    'sku.description',
    'sku.brand',
    'sku.organization.id',
    'sku.organization.key',
    'sku.baseUnit.*',
    'sku.secondaryUnit.*',
    'sku.tertiaryUnit.*',
    'sku.secondaryQty',
    'sku.secondaryCompound',
    'sku.secondaryCompoundQty',
    'sku.skuType.id',
    'sku.skuType.key',
    'sku.skuGroup.*',
    'sku.udfs.key',
    'sku.udfs.value'
  ]),
  'locationsFilters': jsonEncode([
    'id',
    'description',
    'district',
    'phone1',
    'phone2',
    'addressLine1',
    'addressLine2',
    'zipCode',
    'city',
    'state',
    'country',
    'id',
    'key',
    'latitude',
    'longitude',
    'description',
    'deliveryInstructions',
    'locationType.id',
    'locationType.key',
    'locationType.description',
    'locationType.showOnMobileCreate',
    'accountType.id',
    'accountType.key',
    'accountType.description',
    'accountType.color',
    'email',
    'deliveryRadius',
    'consignees.id',
    'consignees.name',
    'consignees.jobTitle',
    'locationOverrideTimeWindows.id',
    'locationOverrideTimeWindows.tw1Open',
    'locationOverrideTimeWindows.tw1Close',
    'locationOverrideTimeWindows.tw2Open',
    'locationOverrideTimeWindows.tw2Close',
    'locationOverrideTimeWindows.monday',
    'locationOverrideTimeWindows.tuesday',
    'locationOverrideTimeWindows.wednesday',
    'locationOverrideTimeWindows.thursday',
    'locationOverrideTimeWindows.friday',
    'locationOverrideTimeWindows.saturday',
    'locationOverrideTimeWindows.sunday',
    'timeWindowType.id',
    'timeWindowType.enabled',
    'timeWindowType.timeWindowTypeDays.id',
    'timeWindowType.timeWindowTypeDays.tw1Open',
    'timeWindowType.timeWindowTypeDays.tw1Close',
    'timeWindowType.timeWindowTypeDays.tw2Open',
    'timeWindowType.timeWindowTypeDays.tw2Close',
    'timeWindowType.timeWindowTypeDays.monday',
    'timeWindowType.timeWindowTypeDays.tuesday',
    'timeWindowType.timeWindowTypeDays.wednesday',
    'timeWindowType.timeWindowTypeDays.thursday',
    'timeWindowType.timeWindowTypeDays.friday',
    'timeWindowType.timeWindowTypeDays.saturday',
    'timeWindowType.timeWindowTypeDays.sunday',
    'appliedTax',
    'creditLimit',
    'appliedTax',
    'taxType',
    'taxID',
    'description',
    'legalName',
    'locationPaymentMethods.id',
    'locationPaymentMethods.limit',
    'locationPaymentMethods.paymentMethod.id'
  ]),
  'ordersFilters': jsonEncode([
    'id',
    'allowShort',
    'newOrder',
    'number',
    'specialInstructions',
    'paymentMethod.id',
    'overReasonCode.id',
    'shortReasonCode.id',
    'actualSize1',
    'actualSize2',
    'actualSize3',
    'plannedSize1',
    'plannedSize2',
    'plannedSize3',
    'actualPickupSize1',
    'actualPickupSize2',
    'actualPickupSize3',
    'damagedSize1',
    'damagedSize2',
    'damagedSize3',
    'plannedPickupSize1',
    'plannedPickupSize2',
    'plannedPickupSize3',
    'size1AliasConfig.*',
    'size2AliasConfig.*',
    'size3AliasConfig.*',
    'key',
    'orderClass.id',
    'orderClass.key',
    'orderClass.allDamaged',
    'orderClass.description',
    'orderInvoices.order.id',
    'orderInvoices.printedFormId',
    'orderInvoices.generatedFormId',
    'orderInvoices.totalValue',
    'orderInvoices.id',
    'orderInvoices.orderInvoiceSource',
    'orderPayments.id',
    'orderPayments.paymentMethod.id',
    'orderPayments.paymentMethod.askPaymentDocument',
    'orderPayments.paymentMethod.description',
    'orderPayments.amount',
    'orderPayments.bank.id',
    'orderPayments.bank.key',
    'orderPayments.dueDate',
    'orderPayments.sequence',
    'orderPayments.documentKey'
  ]),
  'lineItemsFilters': jsonEncode([
    'allowShort',
    'bonusKey',
    'boxKey',
    'id',
    'lineItemID',
    'unitPrice',
    'totalPrice',
    'udfs.id',
    'udfs.key',
    'udfs.value',
    'overReasonCode.id',
    'shortReasonCode.id',
    'actualSize1',
    'actualSize2',
    'actualSize3',
    'plannedSize1',
    'plannedSize2',
    'plannedSize3',
    'actualPickupSize1',
    'actualPickupSize2',
    'actualPickupSize3',
    'damagedSize1',
    'damagedSize2',
    'damagedSize3',
    'plannedPickupSize1',
    'plannedPickupSize2',
    'plannedPickupSize3',
    'size1AliasConfig.*',
    'size2AliasConfig.*',
    'size3AliasConfig.*',
    'sku.id',
    'sku.key',
    'sku.description',
    'sku.brand',
    'sku.organization.id',
    'sku.organization.key',
    'sku.baseUnit.*',
    'sku.secondaryUnit.*',
    'sku.tertiaryUnit.*',
    'sku.secondaryQty',
    'sku.secondaryCompound',
    'sku.secondaryCompoundQty',
    'sku.skuType.id',
    'sku.skuType.key',
    'sku.skuGroup.*',
    'sku.udfs.key',
    'sku.udfs.value',
    'key',
    'unitDiscountSize1',
    'unitTaxSize1',
    'unitTaxSize2',
    'unitTaxSize3',
    'disregardInStock'
  ]),
  'holderMaterialsFilters': jsonEncode([
    'id',
    'size1Alias.*',
    'size1Quantity',
    'size2Alias.*',
    'size2Quantity',
    'size3Alias.*',
    'size3Quantity',
    'transport.id',
    'transport.key',
    'sku.id',
    'sku.key',
    'sku.description',
    'sku.brand',
    'sku.organization.id',
    'sku.organization.key',
    'sku.baseUnit.*',
    'sku.secondaryUnit.*',
    'sku.tertiaryUnit.*',
    'sku.secondaryQty',
    'sku.secondaryCompound',
    'sku.secondaryCompoundQty',
    'sku.skuType.id',
    'sku.skuType.key',
    'sku.skuGroup.*',
    'sku.udfs.key',
    'sku.udfs.value'
  ])
};