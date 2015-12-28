defmodule Earmark.Scanner.ScanLineTest do
  use ExUnit.Case

  alias Earmark.Scanner

  # test "scanning an empty line" do
  #   assert Scanner.scan_line( "" ) == [%Scanner.EmptyLine{}]
  # end
  # test "scanning a simple line" do
  #   assert Scanner.scan_line( "alpha beta" ) == [%Scanner.Text{content: "alpha beta"}]
  # end

  # test "scanning an indented line" do
  #   assert Scanner.scan_line( " alpha") == [%Scanner.Text{content: " alpha"}]
  #   assert Scanner.scan_line( "   alpha") == [%Scanner.Text{content: "   alpha"}]
  #   assert Scanner.scan_line( "    alpha") == [%Scanner.LeadingWS{count: 4},%Scanner.Text{content: "alpha"}]
  #   assert Scanner.scan_line( "     alpha") == [%Scanner.LeadingWS{count: 5},%Scanner.Text{content: "alpha"}]
  # end

  # test "rulers" do
  #   assert Scanner.scan_line( "***" ) == [%Scanner.Ruler{content: "***", type: "*"}]
  #   assert Scanner.scan_line( "_ ___ _" ) == [%Scanner.Ruler{content: "_ ___ _", type: "_"}]
  #   assert Scanner.scan_line( "---" ) == [%Scanner.Ruler{content: "---", type: "-"}]
  #   assert Scanner.scan_line( "_ _")  == [%Scanner.Text{content: "_ _"}]
  #   assert Scanner.scan_line( "**")  == [%Scanner.Text{content: "**"}]
  # end 
end
