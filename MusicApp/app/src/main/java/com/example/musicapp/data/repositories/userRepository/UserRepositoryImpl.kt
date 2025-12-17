package com.example.musicapp.data.repositories.userRepository

import android.util.Log
import com.example.musicapp.data.model.Playlist
import com.example.musicapp.data.model.PlaylistUser
import com.example.musicapp.data.source.UserDataSource
import com.example.musicapp.shared.utils.constant.Constant
import com.example.musicapp.shared.utils.scheduler.DataResult

// Helper function to sanitize playlist image URLs
private fun sanitizePlaylistImages(playlists: ArrayList<Playlist>?): ArrayList<Playlist> {
    if (playlists == null) return arrayListOf()
    return ArrayList(playlists.map { playlist ->
        if (playlist.image.isNullOrBlank()) {
            Playlist(
                id = playlist.id,
                name = playlist.name,
                image = Constant.URL_IMAGE,
                nameArtist = playlist.nameArtist,
                playlistUserLoveId = playlist.playlistUserLoveId,
                songCount = playlist.songCount,
                isSelected = playlist.isSelected
            )
        } else {
            playlist
        }
    })
}

// Helper function to sanitize playlist user image URLs
private fun sanitizePlaylistUserImages(playlists: ArrayList<PlaylistUser>?): ArrayList<PlaylistUser> {
    if (playlists == null) return arrayListOf()
    return ArrayList(playlists.map { playlist ->
        if (playlist.songImage.isNullOrBlank()) {
            // Note: PlaylistUser doesn't have copy() with named parameters, so we need to create new instance
            PlaylistUser(
                playlistUserId = playlist.playlistUserId,
                playlistUserName = playlist.playlistUserName,
                songQuantity = playlist.songQuantity,
                songImage = Constant.URL_IMAGE,
                nameArtist = playlist.nameArtist,
                isSelected = playlist.isSelected
            )
        } else {
            playlist
        }
    })
}

class UserRepositoryImpl(private val dataSource: UserDataSource) : UserRepository {

    override suspend fun createUser(userId: String): DataResult<Boolean> {
        return try {
            val response = dataSource.createUser(userId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun getListPlaylistUser(userId: String): DataResult<ArrayList<PlaylistUser>> {
        return try {
            val response = dataSource.getListPlaylistUser(userId)
            Log.d("UserRepository", "getListPlaylistUser - Response code: ${response.code()}, isSuccessful: ${response.isSuccessful}")
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                Log.d("UserRepository", "getListPlaylistUser - Response body status: ${body.status}, playlists count: ${body.playlists?.size}")
                if (body.status == Constant.STATUS && body.playlists != null) {
                    DataResult.Success(sanitizePlaylistUserImages(body.playlists))
                } else {
                    Log.e("UserRepository", "Invalid status or null playlists: status=${body.status}, playlists=${body.playlists}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                val errorBody = try {
                    response.errorBody()?.string()
                } catch (e: Exception) {
                    null
                }
                Log.e("UserRepository", "Response not successful: code=${response.code()}, message=${response.message()}, errorBody=$errorBody")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            Log.e("UserRepository", "Exception in getListPlaylistUser", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getListPlaylistLove(userId: String): DataResult<ArrayList<Playlist>> {
        return try {
            val response = dataSource.getListPlaylistLove(userId)
            Log.d("UserRepository", "getListPlaylistLove - Response code: ${response.code()}, isSuccessful: ${response.isSuccessful}")
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                Log.d("UserRepository", "getListPlaylistLove - Response body status: ${body.status}, playlists count: ${body.playlists?.size}")
                if (body.status == Constant.STATUS && body.playlists != null) {
                    DataResult.Success(sanitizePlaylistImages(body.playlists))
                } else {
                    Log.e("UserRepository", "Invalid status or null playlists: status=${body.status}, playlists=${body.playlists}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                val errorBody = try {
                    response.errorBody()?.string()
                } catch (e: Exception) {
                    null
                }
                Log.e("UserRepository", "Response not successful: code=${response.code()}, message=${response.message()}, errorBody=$errorBody")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            Log.e("UserRepository", "Exception in getListPlaylistLove", e)
            DataResult.Error(e)
        }
    }

    override suspend fun createPlaylistUser(
        userId: String,
        namePlaylist: String
    ): DataResult<Boolean> {
        return try {
            val response = dataSource.createPlaylistUser(userId, namePlaylist)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun insertSongPlaylistUser(
        playlistUserId: Int,
        songId: Int
    ): DataResult<Boolean> {
        return try {
            val response = dataSource.insertSongPlaylistUser(playlistUserId, songId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else if (response.body() != null && response.body()!!.status == Constant.STATUS_DUPLICATE) {
                DataResult.Success(false)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun deletePlaylistUser(playlistUserId: String): DataResult<Boolean> {
        return try {
            val response = dataSource.deletePlaylistUser(playlistUserId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun deletePlaylistLove(playlistLoveId: String): DataResult<Boolean> {
        return try {
            val response = dataSource.deletePlaylistLove(playlistLoveId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }
}