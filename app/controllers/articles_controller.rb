class ArticlesController < ApplicationController
def new
  end
 def show
end

def create

redl_chance = 0.02
modboost = params[:article][:boost].to_i * 0.1 # 0, 1 to 0, 0.1
modtime = params[:article][:time].to_i
modweather = (params[:article][:weather].to_i - 1) * 0.05 # 1, 2, 3 to 0, 0.05, 0.1 
modsve = params[:article][:sve].to_i + 1 # 1 or 2
modsova = params[:article][:sova].to_i
modkanat = params[:article][:kanat].to_i
modud = params[:article][:ud].to_i * 0.5 + 1
modudmax = params[:article][:ud].to_i + 1
modkle = params[:article][:kle].to_i * 0.5 + 1
modklemax = params[:article][:kle].to_i + 1
mod_fea = params[:article][:fea].to_i + 1
mod_redl = params[:article][:redl].to_i + 1
mod_umelka = params[:article][:umelka].to_i

case mod_umelka
when 1
	fea_chance = 0.02
when 2
	fea_chance = 0.04
when 3 
	fea_chance = 0.05
end
case params[:article][:ozherelka].to_i
when 1
	modkompas = 2
        mod_podkova = 1
when 2
	modkompas = 1
        mod_podkova = 1
when 3 
	modkompas = 1
        mod_podkova = 2.5
end

case modtime 
when 1
	basic = 1 #base cone 1
	max = 1 #same
	chance = 0.4 + modweather + modboost #base 40%
	fl_hour = 10
when 2
	basic = 1.5 #base cone 1 to 2
	max = 2 
	chance = 0.6 + modweather + modboost #base 60%
	fl_hour = 6
when 3
	basic = 2.5 #base cone 2 to 3
	max = 3
	chance = 0.7 + modweather + modboost #base 70%
	fl_hour = 4
end

maxoneflight = (max + modsova + modkanat) * modkompas * modudmax * modklemax
total = (basic + modsova + modkanat) * modkompas * modud * chance * modkle
without_klever = (basic + modsova + modkanat) * modkompas * modud #succesfull flight
hour = total * fl_hour * modsve
maxhour = maxoneflight * fl_hour * modsve


if params[:article][:kle].to_i == 1
wastedklever = fl_hour * modsve * 0.5 #clever chance = 50%
else 
wastedklever = 0
end

params[:article].each do |g|
flash[g[0]] = g[1].to_i
end

flash[:redl_per_hour] = fl_hour * modsve * redl_chance * mod_redl * mod_podkova
flash[:pero_per_hour] = (fl_hour * modsve * fea_chance * mod_fea * chance).round 2
flash[:klever_gives] = without_klever * 50 # clever charges
flash[:klever_spent] = wastedklever
flash[:avg_flight] = total.round 2
flash[:max_flight] = maxoneflight.round 2
flash[:avg_hour] = hour.round 2
flash[:max_hour] = maxhour.round 2
redirect_to :back
  end
end
