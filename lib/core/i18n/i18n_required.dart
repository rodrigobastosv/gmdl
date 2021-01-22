final requiredLocales = ['en', 'pt', 'es', 'ja', 'th', 'de', 'it', 'fr', 'ru'];

final requiredKeys = [
  'task.created',
  'task.start',
  'taskLinked.location',
  'taskLinked.route',
  'taskLinked.equipment',
  'taskLinked.order',
  'taskLinked.eventLog',
  'taskLinked.ruleType',
  'taskLinked.survey',
  'taskLinked.driver',
  'taskLinked.task',
  'taskDetail.relatedInfo',
  'taskDetail.createdDate',
  'taskDetail.title',
  'taskDetail.taskType',
  'taskDetail.description',
  'task.finish',
  'taskDetail.photos.noData',
  'taskDetail.relatedInfo.noData',
  'tasks',
  'task.photos',
  'error.id.unknown',
  'driver.location.withnocoord',
  'order.invalid.quantity',
  'driver.printer.noConnection',
  'driver.printer.missingValues',
  'driver.printer.noDataReceived',
  'driver.printer.zplNotSupported',
  'driver.printer.userQuitApp',
  'driver.select.quantity.products.validity',
  'driver.no.products.selected',
  'driver.products.to.collect',
  'driver.error.printer.app.required',
  'driver.order.class',
  'driver.select.order.class',
  'driver.button.add',
  'driver.title.add.product',
  'add.helper.dialog.hos.message',
  'additionalMaterial',
  'additionalMaterial.implicit',
  'addLocation.title',
  'addressInformation',
  'alertdialog.leaveDC',
  'alertdialog.startroute',
  'apk.checksum.not.present',
  'arrive.with.pending.stops.warning',
  'ask.finish.hos.helper',
  'authenticate.failure',
  'authenticate.helper.to.change.hos.status',
  'Configuration.isEmpty',
  'consignee.addNew',
  'consignee.consigneeName',
  'consignee.form',
  'consignee.jobTitle',
  'contactInformation',
  'countdownPopup.btnNow',
  'damaged',
  'deliveryDays',
  'description',
  'details.label.actualNoColon',
  'details.label.arrival',
  'details.label.departure',
  'details.label.planned',
  'details.label.projected',
  'driver.accountType.title',
  'driver.addressLine1.title',
  'driver.addressLine2.title',
  'driver.amount',
  'driver.arrivalEarlier',
  'driver.arrivalEarlierHours',
  'driver.arrivalLater',
  'driver.arrivalLaterHours',
  'driver.arrivalOnTime',
  'driver.arrivedc',
  'driver.arriving.dc',
  'driver.available.products',
  'driver.balance',
  'driver.break.loop',
  'driver.button.load',
  'driver.button.save',
  'driver.button.tour',
  'driver.cancel.all.stops',
  'driver.cancel.selected.stops',
  'driver.cancel.selected.stops.warning',
  'driver.cancel.suggestedTimeWindowOpen',
  'driver.canceledproducts',
  'driver.cant.arrive.dc',
  'driver.cant.complete.route',
  'driver.city.title',
  'driver.clear.queue.alert',
  'driver.click.to.sign',
  'driver.country.title',
  'driver.customer.comment',
  'driver.customer.feedback',
  'driver.deliveredproducts',
  'driver.deliveryDetail.deliver',
  'driver.departureEarlier',
  'driver.departureEarlierHours',
  'driver.departureLater',
  'driver.departureLaterHours',
  'driver.departureOnTime',
  'driver.district.title',
  'driver.edit.quantity',
  'driver.email.title',
  'driver.equipment.list',
  'driver.equipment.selection',
  'driver.eta',
  'driver.eta.othervisits',
  'driver.finance',
  'driver.financial.summary',
  'driver.finish',
  'driver.forro.popup.accept',
  'driver.forro.popup.acceptsugestion',
  'driver.forro.map.seestoplist',
  'driver.forro.popup.going',
  'driver.forro.popup.next.stop',
  'driver.forro.popup.title',
  'driver.forro.seeonmap',
  'driver.forro.pickstoponlist',
  'driver.go',
  'driver.goodjob.beforevocative',
  'driver.hint.login',
  'driver.hint.password',
  'driver.hos.break.content',
  'driver.hos.driving.content',
  'driver.hos.lunch.content',
  'driver.hos.minTimeAlert',
  'driver.hos.minute',
  'driver.hos.minutes',
  'driver.hos.wait.content',
  'driver.hoscountdown.driver.description',
  'driver.hoscountdown.driver.neutralButton',
  'driver.hoscountdown.driver.positivebutton',
  'driver.hoscountdown.helpers.description',
  'driver.hoscountdown.title',
  'driver.hosEvent.elapsedTime.lessThanOneMinute',
  'driver.hostype.select',
  'driver.how.did.we.do',
  'driver.integration.action.redelivery.stop',
  'driver.integration.bad.data',
  'driver.integration.error.location.not.found',
  'driver.integration.error.no.position.found',
  'driver.integration.update.version.error',
  'driver.item.cancel',
  'driver.item.changePayment',
  'driver.item.edit',
  'driver.item.editing',
  'driver.leave',
  'driver.leavedc',
  'driver.leavingdc',
  'driver.list.header.available',
  'driver.list.header.invoice',
  'driver.list.header.moratorium',
  'driver.list.header.quantity',
  'driver.list.header.unit',
  'driver.loadAudit',
  'driver.loading.data',
  'driver.loan',
  'driver.loanManagement',
  'driver.locationsNear',
  'driver.locationType.title',
  'driver.logs.sent',
  'driver.new.order',
  'driver.next',
  'driver.no.group',
  'driver.onboarding.submit',
  'driver.order.summary',
  'driver.orders',
  'driver.packaging.loan',
  'driver.partial.payment',
  'driver.partial.payment.entry',
  'Driver.password.recovery.part1',
  'Driver.password.recovery.part2',
  'driver.phone1.title',
  'driver.phone2.title',
  'Driver.phoneNumberIsCorrect',
  'driver.previous',
  'driver.pro.resequencing',
  'driver.pro.connectivityError',
  'driver.pro.outdatedError',
  'driver.pro.synchronizing',
  'driver.pro.synced',
  'driver.pro.syncedtimeago',
  'driver.pro.offlineUsingLastProOptimization',
  'driver.pro.offlineOptimizingByDistance',
  'driver.pro.chooseTheNextStop',
  'driver.pro.bulkArrivalNextStop',
  'driver.product.unload',
  'driver.products',
  'driver.time.day',
  'driver.time.days',
  'driver.time.hour',
  'driver.time.hours',
  'driver.time.minute',
  'driver.time.minutes',
  'driver.time.second',
  'driver.time.seconds',
  'driver.queue.processing.message',
  'driver.queue.processing.title',
  'driver.queue.sync.failed',
  'driver.reason.select',
  'driver.received',
  'driver.recovered.credits',
  'driver.remaining.items',
  'driver.reorder.stops',
  'driver.resale',
  'driver.reschedule.popup.content',
  'driver.resetPaymentMethod',
  'driver.returned.value.title',
  'driver.returned.value.warning',
  'driver.routeAtGlance',
  'driver.sales.of.the.day',
  'driver.select.next.stop',
  'driver.select.other',
  'driver.shopping.cart',
  'driver.sign',
  'driver.signature.placeholder',
  'driver.sku.brand',
  'driver.sku.promotion',
  'driver.sku.promotions',
  'driver.smarttrack.emptystops',
  'driver.start.route',
  'driver.state.title',
  'driver.status.gps',
  'driver.status.greenmile',
  'driver.status.network',
  'driver.Stop.arrival.document.to.be.delivered',
  'driver.Stop.arrival.pending.credits',
  'driver.StopDetail.Time.Arrival',
  'driver.submit',
  'driver.tabs.route.map',
  'driver.todaysummary',
  'driver.transport',
  'driver.transport.list',
  'driver.transport.selection',
  'Driver.userIsNotDriver',
  'driver.warn.syncing',
  'driver.welcome',
  'driver.zipcode.title',
  'equipment.hint.login',
  'equipment.button.start',
  'equipment.login',
  'equipment.not.found',
  'equipmentType.size',
  'EventNotification.timeWindows',
  'friday',
  'filterDate.yesterday',
  'filterDate.thisWeek',
  'filterDate.thisMonth',
  'filterDate.lastWeek',
  'filterDate.lastMonth',
  'filterDate.range',
  'general.button.cancel',
  'general.button.confirm',
  'general.button.ok',
  'general.infoPaymentDocument',
  'general.infoPaymentDocumentCheck',
  'general.label.from',
  'general.label.to',
  'general.no',
  'general.paymentMethod',
  'general.reasonCode',
  'general.server',
  'general.survey',
  'general.total',
  'general.yes',
  'Greenmile.Route.IconDescription.arrivedOrigin',
  'filter.route.status.completed',
  'filter.route.status.departedOrigin',
  'filter.route.status.inProgress',
  'filter.route.status.notStarted',
  'filter.route.status.started',
  'helper.in.route',
  'helper.in.route.empty',
  'helper.search.empty',
  'helpers',
  'hos.break.title',
  'hos.driving.title',
  'hos.endBreak',
  'hos.endDriving',
  'hos.endLunch',
  'hos.endWaiting',
  'hos.endWorkTime',
  'hos.errorAtSentQueue',
  'hos.lunch.title',
  'hos.notation',
  'hos.shouldStartDutyAfterLogin',
  'hos.shouldStartDutyOnRouteAtGlance',
  'hos.startWorkTime',
  'hos.sureEndWorkTime',
  'hos.type.noHosType',
  'hos.wait',
  'hos.workday.title',
  'hosSummary',
  'hosSummary.startWorkTime',
  'hosSummary.endWorkTime',
  'hosSummary.startDriving',
  'hosSummary.endDriving',
  'hosSummary.startBreak',
  'hosSummary.endBreak',
  'hosSummary.startLunch',
  'hosSummary.endLunch',
  'hosSummary.startWaiting',
  'hosSummary.endWaiting',
  'hours.remaining.force.break.limit.alert.after',
  'hours.remaining.force.break.limit.alert.before',
  'hours.remaining.force.break.limit.alert.onTime',
  'hours.remaining.force.break.limit.error',
  'hours.remaining.force.lunch.limit.alert.after',
  'hours.remaining.force.lunch.limit.alert.before',
  'hours.remaining.force.lunch.limit.alert.onTime',
  'hours.remaining.force.lunch.limit.error',
  'key',
  'lineItem.lineItemID',
  'list.noResults',
  'load.route.key',
  'loading.reload.data.with.requests',
  'load.route.select.date',
  'loader.change.groupby',
  'loader.lineItem',
  'loader.login.error',
  'loader.none',
  'loader.nothing.found',
  'loader.order',
  'loader.permissions.error',
  'loader.phone',
  'loader.route',
  'loader.route.date',
  'loader.route.list',
  'loader.route.selection',
  'loader.routes.not.found',
  'loader.scan.items',
  'loader.select',
  'loader.server.connected',
  'loader.server.unreachable',
  'loader.server.version.failed',
  'loader.session.expired',
  'loader.settings',
  'loader.sign.out',
  'loader.sku',
  'loader.stop',
  'loader.today',
  'loader.username',
  'loader.validation.invalid.value',
  'loader.validation.required',
  'loader.validation.url',
  'locale.label',
  'location.form.invalid',
  'locationInformation',
  'login.forgotpassword',
  'logout',
  'menu.add.location',
  'menu.bulkarrive.all',
  'menu.bulkarrive.cancel',
  'menu.bulkarrive.departAll',
  'menu.less',
  'menu.load.route',
  'menu.more',
  'menu.stop.navigation',
  'message.status.pending',
  'message.submit',
  'mileageReport',
  'mileageReport.driven',
  'mileageReport.rangeTooBig',
  'mileageReport.start',
  'mileageReport.stop',
  'mileageReport.stops',
  'mileageReport.stopWithoutLocationDescription',
  'mileageReport.totals',
  'mobile.driver.login',
  'monday',
  'now',
  'onboard.card.1.arrive',
  'onboard.card.1.text.circled.checkmark',
  'onboard.card.1.more',
  'onboard.card.1.subtitle',
  'onboard.card.1.text.1',
  'onboard.card.1.text.2',
  'onboard.card.1.text.3',
  'onboard.card.1.text.4',
  'onboard.card.1.text.5',
  'onboard.card.1.text.6',
  'onboard.card.1.title',
  'onboard.card.2.message',
  'onboard.card.2.text.1',
  'onboard.card.2.text.2',
  'onboard.card.2.text.3',
  'onboard.card.2.text.4',
  'onboard.card.2.title',
  'onboard.card.3.message',
  'onboard.card.3.subtitle',
  'onboard.card.3.text.1',
  'onboard.card.3.text.2',
  'onboard.card.3.text.3',
  'onboard.card.3.title',
  'onboard.card.4.text.1',
  'onboard.card.4.text.2',
  'onboard.card.4.text.3',
  'onboard.card.4.title',
  'onboard.card.counter',
  'onboard.card.try.now',
  'onboard.popup.content',
  'onboard.popup.negative.button',
  'onboard.popup.positive.button',
  'onboard.popup.title',
  'options.button.clean',
  'order.lineItem',
  'order.pickup',
  'organizationid',
  'PasswordPolicy.Hint.LowerCaseCharacters',
  'PasswordPolicy.Hint.MinimumLength',
  'PasswordPolicy.Hint.MustHaveNonAlphanumeric',
  'PasswordPolicy.Hint.MustHaveNumber',
  'PasswordPolicy.Hint.UpperCaseCharacters',
  'paymentMethodPopup.title',
  'pendingInvoices',
  'pendingInvoices.dueDate',
  'pendingInvoices.saleDate',
  'pendingInvoices.transactions',
  'permission.user.changepassword',
  'phone1type',
  'phone2type',
  'phoneType.cellularPhone',
  'phoneType.fax',
  'phoneType.homePhone',
  'phoneType.workPhone',
  'photogallery.title',
  'plugin.error',
  'pod.photo',
  'privacy.policy',
  'prompt.photo.album.popup',
  'prompt.photo.album.popup.no',
  'prompt.photo.album.popup.yes',
  'QrCode.read',
  'quantity',
  'Quantity.Must.Be.Over',
  'Quantity.Must.Be.Shorter',
  'reason',
  'reasonCode.need.register',
  'reload.clearData',
  'request.loading.popup.subtitle',
  'request.loading.popup.title',
  'route.add.stop',
  'route.confirmReopenRoute',
  'route.date',
  'route.different.driver',
  'route.different.driverAndEnquipment',
  'route.different.equipment',
  'route.id',
  'route.inlinemenu.arrival',
  'route.performance.summary',
  'route.performance.summary.less',
  'route.performance.summary.more',
  'route.performance.summary.more.less',
  'route.performance.summary.onlytime.less',
  'route.performance.summary.onlytime.more',
  'route.performance.today',
  'route.reopen',
  'route.tab.available',
  'route.tab.done',
  'saturday',
  'seller.balance',
  'search',
  'server.error',
  'server.featureNotSupported',
  'servicetimetypeid',
  'sidemenu.subtitle',
  'sidemenu.title',
  'smartTrack.smartTrack.title',
  'status.arrived',
  'status.cancelled',
  'status.chat',
  'status.complete',
  'status.departed',
  'status.label',
  'status.projected',
  'status.redelivery',
  'status.undeliverable',
  'stop.bulkArrive',
  'stop.cancel',
  'stop.clone',
  'stop.deliveryInstructions',
  'stop.detail.arrive',
  'stop.list',
  'stop.list.NoStopTypeToList',
  'stop.redelivery',
  'stop.section.plannedSizes',
  'stop.signature',
  'stop.signature.title',
  'stop.signtaure.integrityverificationcode',
  'stop.start.service',
  'stop.stopType.title',
  'stop.timetable.title',
  'stopList.stockSales',
  'stopList.tabs.directions',
  'stopList.tabs.pickThisStop',
  'stopList.title',
  'sunday',
  'taxID',
  'thursday',
  'timewindowtypeid',
  'tuesday',
  'user.changePassword.confirmNewPassword',
  'user.changePassword.newPassword',
  'user.changePassword.oldPassword',
  'wednesday',
  'DetailListForm.Search',
  'login.forgotpassword.header',
  'requestApproval.processToken',
  'requestApproval.notificationAttended',
  'requestApproval.notificationApproved',
  'requestApproval.textPaused',
  'requestApproval.popupTitleAttended',
  'requestApproval.clientLabel',
  'requestApproval.messageSupervisor',
  'requestApproval.callSupervisor',
  'requestApproval.textOfflineToken',
  'requestApproval.popupTitleOnline',
  'requestApproval.popupTitleOffline',
  'requestApproval.textOnline',
  'requestApproval.textOffline',
  'requestApproval.nextStop',
  'requestApproval.invalidToken',
  'driver.token.approval',
  'Greenmile.MobileMap.UnitMetrics.kilometers',
  'Greenmile.MobileMap.UnitMetrics.meters',
  'Greenmile.MobileMap.UnitMetrics.miles',
  'selfBilling.title',
  'selfBilling.edit.article',
  'selfBilling.edit.reset',
  'selfBilling.type.missing',
  'selfBilling.type.exceeding',
  'selfBilling.quantity',
  'selfBilling.generateBilling',
  'selfBilling.summary',
  'selfBilling.message',
  'selfBilling.planned',
  'selfBilling.delivered',
  'selfBilling.available',
  'selfBilling.edit.title',
  'selfBilling.article',
  'selfBilling.itemsPlanned',
  'document.print',
  'selfBilling.itemsNotPlanned',
  'selfBilling.document.header',
  'orderInvoice.title',
  'orderInvoice.message',
  'orderInvoice.number',
  'driver.error.creditlimit',
  'driver.selectPaymentMethod',
  'driver.changePayment',
  'driver.remainingAmount',
  'driver.methodPayment',
  'driver.payment.entry',
  'driver.printerPreview.noDocumentsPrinted',
  'driver.printerPreview.documentsPartiallyPrinted',
  'driver.printerPreview.allDocumentsPrinted',
  'driver.printerPreview.printingState',
  'driver.printerPreview.alreadyPrinted',
  'driver.printerPreview.notPrintedYet',
  'driver.documentInvoice.noNumber',
  'driver.printer.viewDocuments',
  'survey.selectAnOption',
  'multiplePaymentsPopup.amountDiference',
  'multiplePaymentsPopup.button.correctDifference',
  'multiplePaymentsPopup.title',
  'report.document.header',
  'driver.documentReport.endOfReport',
  'driver.documentReport.totalHeader',
  'driver.documentReport.reportTotalValue',
  'driver.documentReport.reportTotalValueCredit',
  'driver.documentReport.reportTotalValueCounted',
  'documentReport.buttonTitle',
  'driver.stock.actual',
  'driver.stock.collected',
  'driver.stock.damaged',
  'driver.stock.delivered',
  'driver.stock.initial',
  'driver.stock.intact',
  'driver.stock.missing',
  'driver.stock.print',
  'driver.stock.print.report',
  'driver.stock.title',
  'driver.stock.report',
  'driver.pickup.selectItem',
  'driver.pickup.planned',
  'driver.pickup.collected',
  'driver.pickup.productPickups',
  'driver.pickup.materialsPickup',
  'driver.pickup.otherMaterials',
  'driver.pickup.selectMaterials',
  'driver.pickup.plannedMaterial',
  'driver.pickup.collectedMaterial',
  'driver.pickup.item',
  'driver.pickup.loanItems',
  'driver.pickup.actual',
  'driver.pickup.quantity',
  'driver.pickup.type',
  'driver.pickup.documentsSummary',
  'driver.pickup.leftOver',
  'driver.pickup.missing',
  'driver.pickup.differences',
  'driver.pickup.plannedAbbreviated',
  'driver.pickup.actualAbbreviated',
  'driver.pickup.diffAbbreviated',
  'driver.pickup.doneWithdraw',
  'driver.pickup.plannedWithdraw',
  'driver.pickup.retornableMaterials',
  'driver.pickup.total',
  'selfBilling.error.quantity',
  'selfBilling.title.status',
  'selfBilling.error.status',
  'selfBilling.title.adjust',
  'selfBilling.error.adjust',
  'selfBilling.adjusted',
  'bankCheckPopup.title',
  'bankCheckPopup.checkNumberLabel',
  'bankCheckPopup.bankLabel',
  'bankCheckPopup.dueDateLabel',
  'bankCheck.noNumberCheckErrorMessage',
  'driver.error.printer.hasDocumentsNotPrintedInStop',
  'driver.amountToPay',
  'driver.amountRegistered',
  'driver.amountRemaining',
  'driver.registerPayments',
  'driver.registerPayment',
  'driver.cleanRegisters',
  'driver.noPaymentRegistered',
  'driver.paymentsRegistered',
  'driver.amountEnabled',
  'driver.maxValue',
  'driver.pending.actions.title',
  'bankCheckPopup.dueDateIsInvalid',
  'permission.order.remove',
  'order.add.itemsToCollect',
  'driver.cancel.survey',
  'driver.timeWindowDeliverMessage',
  'driver.order.information',
  'driver.drivingTo',
  'driver.seeMap',
  'driver.seeOnMap',
  'driver.nextStops',
  'driver.nextPlannedStop',
  'driver.nextStopSuggested',
  'driver.chooseOtherStop',
  'driver.countDownMessageToAcceptSuggestion',
  'driver.driveToNextStop',
  'driver.confirmDriveToNextStop',
  'driver.helpers.remove',
  'driver.helpers.add.title',
  'driver.helpers.add',
  'driver.reoderStops.moveToFirst',
  'driver.reoderStops.moveToLast',
  'driver.check.due.date.exceeded',
  'document.send.email',
  'document.email.title',
  'general.button.close',
  'stop.view.instructions',
  'driver.stockReport.messageBeforeRouteEnd',
  'driver.stockReport.finishWithoutPrinting',
  'driver.stockReport.printReport',
  'route.stopInProgrees',
  'waitingrouteoptimization.popup.subtitle',
  'survey.qrcode.number.isNaN',
  'driver.registerPendingPayment',
  'cargoChecking.select.title',
  'cargoChecking.filter.all',
  'cargoChecking.filter.canceled',
  'cargoChecking.filter.completed',
  'cargoChecking.filter.undelivered',
  'cargoChecking.filter.redelivered',
  'cargoChecking.quantity.stops',
  'waitCargoChecking.title',
  'waitCargoChecking.info',
  'waitCargoChecking.step.waiting',
  'waitCargoChecking.step.started',
  'waitCargoChecking.step.completed',
  'cargoChecking.cargo',
  'waitCargoChecking.page.title',
  'routeSimulated.deliveryInfo',
  'routeSimulated.timeWindowLost',
  'routeSimulated.impactsInRouteInfo',
  'routeSimulation.calculatingImpactsInRoute',
  'routeSimulation.problemToCalculateImpact',
  'stop.notSigned',
  'stop.doNotSign',
  'stop.list.stopType',
  'loading.downloading.html',
  'push.bindModule',
  'push.registerDeviceOnServer',
  'loading.downloading.reasonCodes',
  'loading.downloading.route',
  'hos.download.types',
  'loading.downloading.configurations',
  'loading.surveys',
  'Locale.list',
  'Progress.Authenticating',
  'cargoChecking.select.info',
  'cargoChecking.send',
  'order.error.cannotChangeDeliveryCompleted',
  'stop.feedback.signature.title',
  'driver.signature.date',
  'driver.sign.again',
  'consignee.hint',
  'driver.not.signed.yet',
  'order.error.cannotChangeDeliveryNotInProgress',
  'loading.downloading.billingappliedrule',
  'loading.downloading.documenttemplates',
  'driver.signature.coordinates',
  'document.email.invalid',
  'taskFormPage.title',
  'driver.button.saveTask',
  'taskForm.geocodeSuggestionMapInfo',
  'taskForm.geocodeSuggestion',
  'driver.button.saveGeocode',
  'taskForm.geocodeSuggestionTitle',
  'previous.routes',
  'actual.route',
  'route.origin',
  'filter.days.today',
  'filter.days.last7Days',
  'filter.days.last30Days',
  'filter.days.all',
  'menu.stop.newTask',
  'taskType.selectTaskTypeLabel',
  'taskType.continueButtonLabel',
  'driver.transport.audit.title',
  'driver.transport.audit.intro',
  'driver.transport.audit.intro.subtitle',
  'driver.transport.audit.redo.title',
  'driver.transport.audit.redo.subtitle',
  'driver.transport.audit.complete.title',
  'driver.transport.audit.complete.subtitle',
  'survey.camera.title',
  'survey.camera.subtitle',
  'driver.new.order.remaining',
  'driver.new.order.orderclass.max.sizes',
  'login.error',
  'login.separatorText',
  'login.loginClassicText',
  'login.prefixLoginText',
  'driver.documentPreview.sendingDocumentsFailed',
  'driver.documentPreview.tapToEnterAnAddress',
  'driver.documentPreview.automaticDocumentSending',
  'driver.documentPreview.documentsSentSuccessfully',
  'timeWindow.openingTime',
  'timeWindow.closingTime',
  'timeWindow.daysOfDelivery',
  'timeWindow',
  'timeWindow.suggestion.title',
  'timeWindow.openCloseTime',
  'timeWindow.add',
  'timeWindow.selectAllDays',
  'timeWindow.configuration.title',
  'timeWindow.noItems',
  'driver.send.transport.audit',
  'driver.add.order.success',
  'driver.add.orders.success',
  'loader.product',
  'direction.destination',
  'direction.drive.to.destination.title',
  'direction.drive.to.destination.subTitle',
  'taskType.taskType',
  'taskListPage.tab.location',
  'taskListPage.tab.general',
  'taskListPage.title',
  'task.created',
  'task.photos',
  'task.comments',
  'task.comments.placeholder',
  'task.information.required',
  'task.localidad',
  'task.closeTask',
  'task.resolution',
  'task.taskResolution.default',
  'driver.button.saveTask',
  'taskFormPage.title',
  'taskDetail.title',
  'taskDetail.description',
  'taskDetail.createdDate',
  'taskLinked.location',
  'taskLinked.route',
  'taskLinked.equipment',
  'taskLinked.order',
  'taskLinked.eventLog',
  'taskLinked.ruleType',
  'taskLinked.survey',
  'taskLinked.driver',
  'taskLinked.task',
  'task.start',
  'task.finish',
  'CheckDivergences.title',
  'differencesFound.title',
  'reconciliationOfDifferences.title',
  'reconciliationOfDifferences.ask',
  'reconciliationOfDifferences.agree',
  'reconciliationOfDifferences.disagree',
  'reconciliationOfDifferences.message',
  'reconciliationOfDifferences.submit',
  'taskDetail.createdDate',
  'taskDetail.taskType',
  'taskDetail.relatedInfo.noData',
  'taskDetail.relatedInfo',
  'taskDetail.photos.noData',
  'taskDetail.pageTitle',
  'waitCargoChecking.step.reconciliation',
  'driver.sku.type',
  'driver.sku.missing.in.order',
  'driver.missing.items.alert.title',
  'driver.missing.items.alert.description',
  'driver.item.empty.stock',
  'driver.item.missing.stock',
  'loadAuditPopup.title',
  'loadAuditPopup.quantity',
  'driver.signature.conformityOk',
  'driver.signature.conformityAlert',
  'driver.signatureConformity',
  'driver.signature.conformityError',
  'driver.noCoordinates',
  'driver.arrival.conformityOk',
  'driver.arrival.conformityAlert',
  'driver.cancellation.conformityOk',
  'driver.cancellation.conformityAlert',
  'driver.undeliverable.conformityOk',
  'driver.undeliverable.conformityAlert',
  'driver.redelivery.conformityOk',
  'driver.redelivery.conformityAlert',
  'driver.stop.conformityError',
  'stop.feedback.signature.discardSignature',
  'driver.PaymentMethodSumMessage',
  'driver.new.order.sku.with.missing.data'
];