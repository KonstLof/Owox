SELECT date AS Date
      ,coalesce(channelGrouping, 'Unknown') AS Channel
      ,coalesce(utm_source_medium, 'Unknown') AS sourceMedium
      ,coalesce(utm_campaign, 'Unknown') AS Campaign
      ,coalesce(utm_content, 'Unknown') AS Content
      ,coalesce(utm_term, 'Unknown') AS Term
      ,coalesce(country, 'Unknown') as Country
      ,client_ID AS idClient
      ,user_ID AS idUser
      ,transactions AS Transactions
      ,transactionRevenue AS transactionRevenue
      ,g1_complete AS engagedUser30s
      ,g2_complete AS quoteCreated
      ,g3_complete AS engagedUser60s
      ,g7_complete AS viewedSignupPage
      ,g8_complete AS signupServerSide
      ,g9_complete AS quoteCreated2
      ,g10_complete AS signupFrontEnd
      ,g11_complete AS quoteAccepted
      ,g12_complete AS inProductionPurchASe
      ,g13_complete AS cadFileUpload
      ,g16_complete AS engagedUserBlog
      ,g17_complete AS clickedBtnInstantQuote
  FROM {{ get_big_table_name() }}
 WHERE cast(date as date) between {{ get_load_start() }} and {{ get_load_end() }}
