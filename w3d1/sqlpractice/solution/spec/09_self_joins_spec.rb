require 'rspec'
require '09_self_joins'

describe "self-JOIN exercises" do
  describe "num_stops" do
    it "shows the number of stops in the table" do
      expect(num_stops).to contain_exactly(["246"])
    end
  end

  describe "craiglockhart_id" do
    it "shows the ID of the stop Craiglockhart" do
      expect(craiglockhart_id).to contain_exactly(["53"])
    end
  end

  describe "lrt_stops" do
    it "shows the ids and names of stops on the 4 LRT service" do
      expect(lrt_stops).to contain_exactly(
        ["19", "Bingham"],
        ["177", "Northfield"],
        ["149", "London Road"],
        ["194", "Princes Street"],
        ["115", "Haymarket"],
        ["53", "Craiglockhart"],
        ["179", "Oxgangs"],
        ["85", "Fairmilehead"],
        ["117", "Hillend"]
      )
    end
  end

  describe "connecting_routes" do
    it "shows the routes that connect London Road with Craiglockhart" do
      expect(connecting_routes).to contain_exactly(
        ["LRT", "47", "1"],
        ["LRT", "5", "1"],
        ["LRT", "43", "1"],
        ["LRT", "44", "1"],
        ["LRT", "27", "1"],
        ["LRT", "34", "1"],
        ["LRT", "63", "1"],
        ["LRT", "26A", "1"],
        ["SMT", "113", "1"],
        ["SMT", "124", "1"],
        ["LRT", "20", "1"],
        ["LRT", "42", "1"],
        ["LRT", "87A", "1"],
        ["SMT", "C55", "1"],
        ["LRT", "15", "1"],
        ["LRT", "35", "1"],
        ["SMT", "66A", "1"],
        ["LRT", "75", "1"],
        ["LRT", "87", "1"],
        ["SMT", "106", "1"],
        ["LRT", "65", "1"],
        ["LRT", "51", "1"],
        ["LRT", "10", "1"],
        ["LRT", "46A", "1"],
        ["SMT", "C5", "1"],
        ["LRT", "45", "2"],
        ["SMT", "66", "1"],
        ["LRT", "4", "2"]
      )
    end
  end

  describe "cl_to_lr" do
    it "shows routes from Craiglockhart to London Road" do
      expect(cl_to_lr).to contain_exactly(
        ["LRT", "4", "53", "19"],
        ["LRT", "4", "53", "177"],
        ["LRT", "4", "53", "149"],
        ["LRT", "4", "53", "194"],
        ["LRT", "4", "53", "115"],
        ["LRT", "4", "53", "53"],
        ["LRT", "4", "53", "179"],
        ["LRT", "4", "53", "85"],
        ["LRT", "4", "53", "117"],
        ["LRT", "10", "53", "215"],
        ["LRT", "10", "53", "162"],
        ["LRT", "10", "53", "167"],
        ["LRT", "10", "53", "137"],
        ["LRT", "10", "53", "141"],
        ["LRT", "10", "53", "194"],
        ["LRT", "10", "53", "230"],
        ["LRT", "10", "53", "53"],
        ["LRT", "10", "53", "46"],
        ["LRT", "10", "53", "231"],
        ["LRT", "27", "53", "215"],
        ["LRT", "27", "53", "59"],
        ["LRT", "27", "53", "37"],
        ["LRT", "27", "53", "112"],
        ["LRT", "27", "53", "230"],
        ["LRT", "27", "53", "53"],
        ["LRT", "27", "53", "179"],
        ["LRT", "27", "53", "120"],
        ["LRT", "45", "53", "33"],
        ["LRT", "45", "53", "71"],
        ["LRT", "45", "53", "177"],
        ["LRT", "45", "53", "149"],
        ["LRT", "45", "53", "112"],
        ["LRT", "45", "53", "230"],
        ["LRT", "45", "53", "53"],
        ["LRT", "45", "53", "46"],
        ["LRT", "45", "53", "60"],
        ["LRT", "45", "53", "201"],
        ["LRT", "47", "53", "37"],
        ["LRT", "47", "53", "112"],
        ["LRT", "47", "53", "230"],
        ["LRT", "47", "53", "53"],
        ["LRT", "47", "53", "46"],
        ["LRT", "47", "53", "60"],
        ["LRT", "47", "53", "10"],
        ["LRT", "47", "53", "45"],
        ["LRT", "47", "53", "11"]
      )
    end
  end

  describe "cl_to_lr_by_name" do
    it "shows routes from Craiglockhart to London Road" do
      expect(cl_to_lr_by_name).to contain_exactly(
        ["LRT", "4", "Craiglockhart", "Bingham"],
        ["LRT", "4", "Craiglockhart", "Northfield"],
        ["LRT", "4", "Craiglockhart", "London Road"],
        ["LRT", "4", "Craiglockhart", "Princes Street"],
        ["LRT", "4", "Craiglockhart", "Haymarket"],
        ["LRT", "4", "Craiglockhart", "Craiglockhart"],
        ["LRT", "4", "Craiglockhart", "Oxgangs"],
        ["LRT", "4", "Craiglockhart", "Fairmilehead"],
        ["LRT", "4", "Craiglockhart", "Hillend"],
        ["LRT", "10", "Craiglockhart", "Silverknowes"],
        ["LRT", "10", "Craiglockhart", "Muirhouse"],
        ["LRT", "10", "Craiglockhart", "Newhaven"],
        ["LRT", "10", "Craiglockhart", "Leith"],
        ["LRT", "10", "Craiglockhart", "Leith Walk"],
        ["LRT", "10", "Craiglockhart", "Princes Street"],
        ["LRT", "10", "Craiglockhart", "Tollcross"],
        ["LRT", "10", "Craiglockhart", "Craiglockhart"],
        ["LRT", "10", "Craiglockhart", "Colinton"],
        ["LRT", "10", "Craiglockhart", "Torphin"],
        ["LRT", "27", "Craiglockhart", "Silverknowes"],
        ["LRT", "27", "Craiglockhart", "Crewe Toll"],
        ["LRT", "27", "Craiglockhart", "Canonmills"],
        ["LRT", "27", "Craiglockhart", "Hanover Street"],
        ["LRT", "27", "Craiglockhart", "Tollcross"],
        ["LRT", "27", "Craiglockhart", "Craiglockhart"],
        ["LRT", "27", "Craiglockhart", "Oxgangs"],
        ["LRT", "27", "Craiglockhart", "Hunters Tryst"],
        ["LRT", "45", "Craiglockhart", "Brunstane"],
        ["LRT", "45", "Craiglockhart", "Duddingston"],
        ["LRT", "45", "Craiglockhart", "Northfield"],
        ["LRT", "45", "Craiglockhart", "London Road"],
        ["LRT", "45", "Craiglockhart", "Hanover Street"],
        ["LRT", "45", "Craiglockhart", "Tollcross"],
        ["LRT", "45", "Craiglockhart", "Craiglockhart"],
        ["LRT", "45", "Craiglockhart", "Colinton"],
        ["LRT", "45", "Craiglockhart", "Currie"],
        ["LRT", "45", "Craiglockhart", "Riccarton Campus"],
        ["LRT", "47", "Craiglockhart", "Canonmills"],
        ["LRT", "47", "Craiglockhart", "Hanover Street"],
        ["LRT", "47", "Craiglockhart", "Tollcross"],
        ["LRT", "47", "Craiglockhart", "Craiglockhart"],
        ["LRT", "47", "Craiglockhart", "Colinton"],
        ["LRT", "47", "Craiglockhart", "Currie"],
        ["LRT", "47", "Craiglockhart", "Balerno"],
        ["LRT", "47", "Craiglockhart", "Cockburn Crescent"],
        ["LRT", "47", "Craiglockhart", "Balerno Church"]
      )
    end
  end

  describe "haymarket_and_leith" do
    it "shows services connecting Haymarket and Leith" do
      expect(haymarket_and_leith).to contain_exactly(
        ["LRT", "12"],
        ["LRT", "2"],
        ["LRT", "22"],
        ["LRT", "25"],
        ["LRT", "2A"],
        ["SMT", "C5"]
      )
    end
  end

  describe "craiglockhart_and_tollcross" do
    it "shows services connecting Craiglockhart and Tollcross" do
      expect(craiglockhart_and_tollcross).to contain_exactly(
        ["LRT", "10"],
        ["LRT", "27"],
        ["LRT", "45"],
        ["LRT", "47"]
      )
    end
  end

  describe "start_at_craiglockhart" do
    it "shows stops that can be reached by taking one bus from Craiglockhart" do
      expect(start_at_craiglockhart).to contain_exactly(
        ["Bingham", "LRT", "4"],
        ["Northfield", "LRT", "4"],
        ["London Road", "LRT", "4"],
        ["Princes Street", "LRT", "4"],
        ["Haymarket", "LRT", "4"],
        ["Craiglockhart", "LRT", "4"],
        ["Oxgangs", "LRT", "4"],
        ["Fairmilehead", "LRT", "4"],
        ["Hillend", "LRT", "4"],
        ["Silverknowes", "LRT", "10"],
        ["Muirhouse", "LRT", "10"],
        ["Newhaven", "LRT", "10"],
        ["Leith", "LRT", "10"],
        ["Leith Walk", "LRT", "10"],
        ["Princes Street", "LRT", "10"],
        ["Tollcross", "LRT", "10"],
        ["Craiglockhart", "LRT", "10"],
        ["Colinton", "LRT", "10"],
        ["Torphin", "LRT", "10"],
        ["Silverknowes", "LRT", "27"],
        ["Crewe Toll", "LRT", "27"],
        ["Canonmills", "LRT", "27"],
        ["Hanover Street", "LRT", "27"],
        ["Tollcross", "LRT", "27"],
        ["Craiglockhart", "LRT", "27"],
        ["Oxgangs", "LRT", "27"],
        ["Hunters Tryst", "LRT", "27"],
        ["Brunstane", "LRT", "45"],
        ["Duddingston", "LRT", "45"],
        ["Northfield", "LRT", "45"],
        ["London Road", "LRT", "45"],
        ["Hanover Street", "LRT", "45"],
        ["Tollcross", "LRT", "45"],
        ["Craiglockhart", "LRT", "45"],
        ["Colinton", "LRT", "45"],
        ["Currie", "LRT", "45"],
        ["Riccarton Campus", "LRT", "45"],
        ["Canonmills", "LRT", "47"],
        ["Hanover Street", "LRT", "47"],
        ["Tollcross", "LRT", "47"],
        ["Craiglockhart", "LRT", "47"],
        ["Colinton", "LRT", "47"],
        ["Currie", "LRT", "47"],
        ["Balerno", "LRT", "47"],
        ["Cockburn Crescent", "LRT", "47"],
        ["Balerno Church", "LRT", "47"]
      )
    end
  end

  describe "craiglockhart_to_sighthill" do
    it "shows routes involving two buses from Craiglockhart to Sighthill" do
      expect(craiglockhart_to_sighthill).to contain_exactly(
        ["4", "LRT", "London Road", "34", "LRT"],
        ["4", "LRT", "London Road", "35", "LRT"],
        ["4", "LRT", "London Road", "65", "LRT"],
        ["4", "LRT", "London Road", "C5", "SMT"],
        ["4", "LRT", "Princes Street", "3", "LRT"],
        ["4", "LRT", "Princes Street", "30", "LRT"],
        ["4", "LRT", "Princes Street", "3A", "LRJ"],
        ["4", "LRT", "Princes Street", "65", "LRT"],
        ["4", "LRT", "Princes Street", "C5", "SMT"],
        ["4", "LRT", "Princes Street", "C70", "SMT"],
        ["4", "LRT", "Haymarket", "22", "LRT"],
        ["4", "LRT", "Haymarket", "22A", "LRT"],
        ["4", "LRT", "Haymarket", "25", "LRT"],
        ["4", "LRT", "Haymarket", "3", "LRT"],
        ["4", "LRT", "Haymarket", "30", "LRT"],
        ["4", "LRT", "Haymarket", "3A", "LRJ"],
        ["4", "LRT", "Haymarket", "61", "LRT"],
        ["4", "LRT", "Haymarket", "61", "SMT"],
        ["4", "LRT", "Haymarket", "65", "LRT"],
        ["4", "LRT", "Haymarket", "C5", "SMT"],
        ["4", "LRT", "Haymarket", "C70", "SMT"],
        ["4", "LRT", "Oxgangs", "32", "LRT"],
        ["4", "LRT", "Oxgangs", "52", "LRT"],
        ["4", "LRT", "Fairmilehead", "32", "LRT"],
        ["4", "LRT", "Fairmilehead", "52", "LRT"],
        ["10", "LRT", "Muirhouse", "32", "LRT"],
        ["10", "LRT", "Muirhouse", "52", "LRT"],
        ["10", "LRT", "Newhaven", "22", "LRT"],
        ["10", "LRT", "Newhaven", "25", "LRT"],
        ["10", "LRT", "Newhaven", "32", "LRT"],
        ["10", "LRT", "Newhaven", "52", "LRT"],
        ["10", "LRT", "Leith", "22", "LRT"],
        ["10", "LRT", "Leith", "25", "LRT"],
        ["10", "LRT", "Leith", "32", "LRT"],
        ["10", "LRT", "Leith", "34", "LRT"],
        ["10", "LRT", "Leith", "35", "LRT"],
        ["10", "LRT", "Leith", "52", "LRT"],
        ["10", "LRT", "Leith", "C5", "SMT"],
        ["10", "LRT", "Leith Walk", "22", "LRT"],
        ["10", "LRT", "Leith Walk", "22A", "LRT"],
        ["10", "LRT", "Leith Walk", "25", "LRT"],
        ["10", "LRT", "Princes Street", "3", "LRT"],
        ["10", "LRT", "Princes Street", "30", "LRT"],
        ["10", "LRT", "Princes Street", "3A", "LRJ"],
        ["10", "LRT", "Princes Street", "65", "LRT"],
        ["10", "LRT", "Princes Street", "C5", "SMT"],
        ["10", "LRT", "Princes Street", "C70", "SMT"],
        ["10", "LRT", "Colinton", "32", "LRT"],
        ["10", "LRT", "Colinton", "52", "LRT"],
        ["27", "LRT", "Canonmills", "34", "LRT"],
        ["27", "LRT", "Canonmills", "35", "LRT"],
        ["27", "LRT", "Oxgangs", "32", "LRT"],
        ["27", "LRT", "Oxgangs", "52", "LRT"],
        ["45", "LRT", "Brunstane", "32", "LRT"],
        ["45", "LRT", "Brunstane", "52", "LRT"],
        ["45", "LRT", "London Road", "34", "LRT"],
        ["45", "LRT", "London Road", "35", "LRT"],
        ["45", "LRT", "London Road", "65", "LRT"],
        ["45", "LRT", "London Road", "C5", "SMT"],
        ["45", "LRT", "Colinton", "32", "LRT"],
        ["45", "LRT", "Colinton", "52", "LRT"],
        ["45", "LRT", "Currie", "61", "LRT"],
        ["45", "LRT", "Riccarton Campus", "22A", "LRT"],
        ["45", "LRT", "Riccarton Campus", "61", "SMT"],
        ["45", "LRT", "Riccarton Campus", "65", "LRT"],
        ["47", "LRT", "Canonmills", "34", "LRT"],
        ["47", "LRT", "Canonmills", "35", "LRT"],
        ["47", "LRT", "Colinton", "32", "LRT"],
        ["47", "LRT", "Colinton", "52", "LRT"],
        ["47", "LRT", "Currie", "61", "LRT"]
      )
    end
  end
end
