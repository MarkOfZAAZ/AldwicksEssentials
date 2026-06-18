# Aldwicks Essential Components For Delphi 13.1
This is the repository for all the Delphi components I have created for use in the various application suites under Delphi 12.2

## Database Query Helpers (June 2026)
Helpers for Devart TMyQuery components and FireDAC TFDQuery components to check field value uniqueness
in a MySQL or  SQLite table, with optional exclusion of a known row (e.g. on update).

## SpeedButtonsZaaz (June 2026)
I have designed a set of TSpeedButton derived components, which have the TSkSvg icon inside them to make it easier to add just the button to the UI, rather than having to add the button then add the SVG tehn set the HitTest := False; etc


## ComboEditZaaz
This is exposes the CharCase property that for some reason is hidden in the base component TComboEdit

## ListViewZaaz
This exposes some properties of the TListView component, and further adds some new features and default stylings for the TSearchBox section of the component.

## ListViewZaazFilter
Building on **ListViewZaaz** this adds a TSpeedButton (FilterButton) with a TSkSVG component in the TSearchBar. It further exposes an event OnFilterButtonCLick that can be used when the user clicks the button.

## Authors
Mark Richards [@TheCodeGugru](https://zaazapps.co.uk)

## Version History
* 25.3.21.1 **Initial Repository Build**

## License
This project and all its contents are Copyright © 2025, Aldwicks Limited.
No unauthorised use of this project exists or is implied without prior written consent.

## Disclaimer

This software is provided "as is," without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement.

The use of this software is entirely at your own risk. In no event shall the authors or copyright holders be liable for any claim, damages, or other liabilities, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

## Acknowledgments
* [ChatGPT](https://openai.com) (For getting it wrong so many times!)
