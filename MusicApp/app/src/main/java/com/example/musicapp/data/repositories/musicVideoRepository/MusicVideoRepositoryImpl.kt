package com.example.musicapp.data.repositories.musicVideoRepository

import android.util.Log
import com.example.musicapp.data.model.Category
import com.example.musicapp.data.model.MusicVideo
import com.example.musicapp.data.model.Topic
import com.example.musicapp.data.source.MusicVideoDataSource
import com.example.musicapp.shared.utils.constant.Constant
import com.example.musicapp.shared.utils.scheduler.DataResult

// Helper function to sanitize music video image URLs
private fun sanitizeMusicVideoImages(musicVideos: ArrayList<MusicVideo>?): ArrayList<MusicVideo> {
    if (musicVideos == null) return arrayListOf()
    return ArrayList(musicVideos.map { video ->
        val sanitizedImage = if (video.musicVideoImage.isNullOrBlank()) Constant.URL_IMAGE else video.musicVideoImage
        val sanitizedArtistImage = if (video.artistImage.isNullOrBlank()) Constant.URL_IMAGE else video.artistImage
        MusicVideo(
            musicVideoId = video.musicVideoId,
            musicVideoName = video.musicVideoName,
            musicVideoImage = sanitizedImage,
            musicVideoTime = video.musicVideoTime,
            musicVideoProposalNew = video.musicVideoProposalNew,
            artistId = video.artistId,
            artistName = video.artistName,
            artistImage = sanitizedArtistImage,
            topicId = video.topicId
        )
    })
}

class MusicVideoRepositoryImpl(private val dataSource: MusicVideoDataSource) : MusicVideoRepository {
    override suspend fun getListMusicVideo(): DataResult<ArrayList<MusicVideo>> {
        return try {
            val response = dataSource.getListMusicVideo()
            Log.d("MusicVideoRepository", "getListMusicVideo - Response code: ${response.code()}, isSuccessful: ${response.isSuccessful}")
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                Log.d("MusicVideoRepository", "getListMusicVideo - Response body status: ${body.status}, musicVideos count: ${body.musicVideos?.size}")
                if (body.status == Constant.STATUS && body.musicVideos != null) {
                    DataResult.Success(sanitizeMusicVideoImages(body.musicVideos))
                } else {
                    Log.e("MusicVideoRepository", "Invalid status or null musicVideos: status=${body.status}, musicVideos=${body.musicVideos}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                val errorBody = try {
                    response.errorBody()?.string()
                } catch (e: Exception) {
                    null
                }
                Log.e("MusicVideoRepository", "Response not successful: code=${response.code()}, message=${response.message()}, errorBody=$errorBody")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            Log.e("MusicVideoRepository", "Exception in getListMusicVideo", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getListMusicVideoDetail(musicVideoId: String): DataResult<ArrayList<MusicVideo>> {
        return try {
            val response = dataSource.getListMusicVideoDetail(musicVideoId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(response.body()!!.musicVideos)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        }catch (e : Exception){
            DataResult.Error(e)
        }
    }

    override suspend fun getListTopic(): DataResult<ArrayList<Topic>> {
        return try {
            val response = dataSource.getListTopic()
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(response.body()!!.topics)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }
}