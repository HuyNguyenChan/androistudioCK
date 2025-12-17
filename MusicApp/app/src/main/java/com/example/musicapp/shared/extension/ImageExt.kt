package com.example.musicapp.shared.extension

import android.graphics.drawable.Drawable
import android.net.Uri
import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide
import com.example.musicapp.R
import com.example.musicapp.shared.utils.ApiConfig

@BindingAdapter("imageUrl")
fun ImageView.loadImageUrl(url : String?){
    if (url.isNullOrBlank()) {
        this.setImageResource(R.drawable.img_2)
    } else {
        // Sử dụng ApiConfig để convert đường dẫn tương đối thành URL đầy đủ
        // Hỗ trợ cả URL đầy đủ (http://, https://) và đường dẫn tương đối từ server (/public/...)
        val imageUrl = ApiConfig.getFullUrl(url)
        
        if (imageUrl != null) {
            Glide.with(context)
                .load(imageUrl)
                .centerCrop()
                .placeholder(R.drawable.img_2)
                .error(R.drawable.img_2)
                .into(this)
        } else {
            this.setImageResource(R.drawable.img_2)
        }
    }
}

@BindingAdapter("imageUrlUser")
fun ImageView.loadImageUrlUser(url : String?){
    if (url.isNullOrBlank()) {
        this.setImageResource(R.drawable.img)
    } else {
        // Sử dụng ApiConfig để convert đường dẫn tương đối thành URL đầy đủ
        val imageUrl = ApiConfig.getFullUrl(url)
        
        if (imageUrl != null) {
            Glide.with(context)
                .load(imageUrl)
                .centerCrop()
                .placeholder(R.drawable.img)
                .error(R.drawable.img)
                .into(this)
        } else {
            this.setImageResource(R.drawable.img)
        }
    }
}