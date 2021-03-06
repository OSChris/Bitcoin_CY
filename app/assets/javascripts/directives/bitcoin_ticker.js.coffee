angular.module('btcdash')

.directive('bitcoinTicker', ['BitcoinCurrencyApi', '$animate', '$timeout', (BitcoinCurrencyApi, $animate, $timeout) ->
  restrict: 'E'
  replace: true
  controller: 'BitcoinTickerController'
  template: """
    <div class="col-sm-5">
      <div class="straight-edge well text-center">
        <h2 class="currency-header">
          <img ng-src="img/{{currencyId}}.png" alt="{{ethnicity}} Flag">
          {{currencyId | uppercase}} {{currencySymbol}}/<i class="fa fa-btc fa-1x"></i>
        </h2>

        <div class="price-box">
          <h1 id="{{currencyId}}">
             <amount-watcher></amount-watcher>
           </h1>
        </div>

        <p class="littlegrey">
          <span ng-show="previousAmount">
            Previous: {{ previousAmount | currency : currencySymbol }}
          </span>
        </p>

        <div class="row">
          <div class="col-sm-6 col-sm-offset-3 difference-box">
            <h3>
              <span ng-show="amountChange">
                {{amountChange}} <i ng-class="{ 'fa-caret-square-o-up positive-change': valueWentUp(), 'fa-caret-square-o-down negative-change': valueWentDown() }" id="{{currencyId}}-change" class="fa fa-1x"></i>
              </span>
            </h3>
          </div>
        </div>
      </div>
   </div>
  """

  scope:
    currencyId: '@'
    ethnicity: '@'
    currencySymbol: '@'

  link: (scope, element, attrs) ->
    BitcoinCurrencyApi.addCurrencyId(scope.currencyId)


])
.directive('amountWatcher', ['$animate', '$timeout', ($animate,$timeout) ->
  restrict: 'E'
  template: """
    <span ng-show="amount"
         class="price-amount"
         ng-class="{'positive-change': valueWentUp(), 'negative-change': valueWentDown(), 'no-change': valueDidNotChange()}">
    {{amount | currency : currencySymbol }}
    </span>
  """
  link: (scope, element) ->
    scope.$watch('amount', (newVal) ->
      $animate.addClass(element.children(), 'animated flash', ->
        $timeout ->
          $animate.removeClass(element.children(), 'animated flash')
          5000))
  ])


