
*** Settings ***
Documentation     scraping data from dart
Library           RPA.Browser.Selenium
Library           RPA.Excel.Files


*** Variables ***
${URL}     http://dart.fss.or.kr/dsac001/mainAll.do

*** Tasks ***
Minimal task
    Open Available Browser    ${URL}
   
    Create Workbook  공시최근100개.xlsx
    FOR    ${index}    IN RANGE    1  101
        ${시간}=              Get Text     xpath://tbody/tr[${index}]/td[1]
        ${공시대상회사}=       Get Text     xpath://tbody/tr[${index}]/td[2]
        ${보고서명}=          Get Text     xpath://tbody/tr[${index}]/td[3]
        ${제출인}=            Get Text     xpath://tbody/tr[${index}]/td[4]
        ${접수일자}=          Get Text     xpath://tbody/tr[${index}]/td[5]
        ${비고}=              Get Text     xpath://tbody/tr[${index}]/td[6]

        &{row}=       Create Dictionary
        ...           시간           ${시간}
        ...           공시대상회사    ${공시대상회사}
        ...           보고서명        ${보고서명}
        ...           제출인          ${제출인}
        ...           접수일자        ${접수일자}
        ...           비고           ${비고}
        Append Rows to Worksheet  ${row}  header=${TRUE}
    END
    Save Workbook    .//output//공시최근100개.xlsx
