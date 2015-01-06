class ContactsController < ApplicationController
  def index
    display = {:contacts => {
      :own_contacts => User.find(params[:id]).contacts.all,
      :shared => User.find(params[:id]).shared_contacts
    }}
    render json: display
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: @contact
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  private

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
end
