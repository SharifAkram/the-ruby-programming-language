# Compute 2006 U.S. income tax using case and Range objects

tax = case income
  when 0..7550
    income*0.1
  when 7550..30650
    755 + (income-7550)*0.15
  when 30650..74200
    4220 + (income-30655)*0.25
  when 74200..154800
    15107.5 + (income-74201)*0.28
  when 154800..336550
    37675.5 + (income-154800)*0.33
  else
    97653 + (income-336550)*0.35
  end
