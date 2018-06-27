class ImagesController < ApplicationController
  before_action :load_product, only: %i(create destroy)

  def create
    add_more_images images_params[:images]
    flash[:danger] = t ".fail" unless @product.save
    redirect_to edit_admin_product_path @product
  end

  def destroy
    remove_image_at_index params[:id].to_i
    flash[:danger] = t ".fail" unless @product.save
    redirect_to edit_admin_product_path @product
  end

  private

  def add_more_images new_images
    images = @product.images
    images += new_images
    @product.update_attributes images: images
  end

  def remove_image_at_index index
    images = @product.images
    images.delete_at index
    @product.update_attributes images: images
  end

  def images_params
    params.require(:product).permit images: []
  end

  def load_product
    @product = Product.actived.find_by id: params[:product_id]
    return if @product
    flash[:danger] = t "products.product_not_found"
    redirect_to root_path
  end
end
