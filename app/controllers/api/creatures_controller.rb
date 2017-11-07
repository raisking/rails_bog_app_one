class Api::CreaturesController < ApplicationController
    #display all creatures
    def index
        #get all creatures from db and save to instance variable
        @creatures = Creature.all

        render json: @creatures
    end
    #create a new creature in the database
    def create 
        #whitelist params and save them to a variable 
        creature_params = params.require(:creature).permit(:name, :description)
        #create a new creature from 'creature_params'
        @creature = Creature.new(creature_params)
        #if creature saves, render the new creature in JSON
        if @creature.save   
            render json: @creature
        end
    end
    #update a creature in the database
    def update
        #get the creature id from the url params
        creature_id = params[:id]
        #use `creature_id` to find the creature in the database and save to variable
        @creature = Creature.find_by_id(creature_id)
        #whitelist params and save them to a variable
        creature_params = params.require(:creature).permit(:name, :description)
        #update the creature based on params
        @creature.update_attributes(creature_params)
        #render JSON of updated creature
        render json: @creature
    end
    def destroy
        #get the creature id from the url params
        creature_id = params[:id]
        #use `creature_id` to find the creature in the database and save it to a variable
        @creature = Creature.find_by_id(creature_id)
        #destroy the creature
        @creature.destroy

        render json: {
            msg: "Successfully Deleted"
        }
    end

    private
    def creature_params
        #whitelist params return whitelisted version
        params.require(:creature).permit(:name, :description)
    end

end
