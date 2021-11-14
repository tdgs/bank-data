require "watir"

module BankData
  module AlphaBank
    class Crawler
      def self.statement_csv(download_path, username, password)
        prefs = {
          "download" => {
            "prompt_for_download" => false,
            "default_directory" => download_path
          }
        }

        browser = Watir::Browser.new :chrome, options: {prefs: prefs}

        browser.goto "https://secure.alpha.gr/Login/myalphaweb/el"
        browser.text_field(id: "inputUsername").set username
        browser.text_field(id: "inputPassword").set password
        browser.button(id: "submitButton").click

        browser.link(text: "Κλείσιμο").click
        browser.link(text: "Συνέχεια").click
        browser.goto "https://secure.alpha.gr/myAlphaWeb/business/#/accounts/details/ODgzOTMxNQ==/"
        sleep 2
        browser.text_field(id: "dateFrom").set("01/05/2021")
        browser.text_field(id: "dateTo").set("31/05/2021")
        browser.link("data-ng-click": "vm.getStatementsWithFilter()").click
        browser.div("data-document-type": "CSV").links.first.click
        browser.link("data-ng-click": "logout()").click
      end
    end
  end
end
