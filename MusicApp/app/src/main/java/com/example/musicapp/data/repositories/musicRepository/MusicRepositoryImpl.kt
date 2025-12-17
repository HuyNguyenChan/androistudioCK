package com.example.musicapp.data.repositories.musicRepository

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.musicapp.data.model.Lyric
import com.example.musicapp.data.model.Song
import com.example.musicapp.data.model.SongAgain
import com.example.musicapp.data.source.MusicDataSource
import com.example.musicapp.shared.utils.constant.Constant
import com.example.musicapp.shared.utils.scheduler.DataResult

// Helper function to sanitize image URLs
private fun sanitizeSongImages(songs: ArrayList<Song>?): ArrayList<Song> {
    if (songs == null) return arrayListOf()
    return ArrayList(songs.map { song ->
        if (song.image.isNullOrBlank()) {
            Song(
                songLoveId = song.songLoveId,
                id = song.id,
                name = song.name,
                image = Constant.URL_IMAGE,
                url = song.url,
                nameArtis = song.nameArtis,
                download = song.download
            )
        } else {
            song
        }
    })
}


class MusicRepositoryImpl(
    private val remote: MusicDataSource.Remote,
    private val local: MusicDataSource.Local
) : MusicRepository {

   override suspend fun getListSong(): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSong()
            android.util.Log.d("MusicRepository", "getListSong - Response code: ${response.code()}, isSuccessful: ${response.isSuccessful}")
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                android.util.Log.d("MusicRepository", "getListSong - Response body status: ${body.status}, songs count: ${body.songs?.size}")
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}, songs=${body.songs}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                val errorBody = try {
                    response.errorBody()?.string()
                } catch (e: Exception) {
                    null
                }
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}, message=${response.message()}, errorBody=$errorBody")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSong", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getListSongLove(userId: String): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSongLove(userId)
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSongLove", e)
            DataResult.Error(e)
        }
    }

    override suspend fun createSongLove(userId: String, songId: Int): DataResult<Boolean> {
        return try {
            val response = remote.createSongLove(userId, songId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun createSongAgain(userId: String, songId: Int): DataResult<Boolean> {
        return try {
            val response = remote.createSongAgain(userId, songId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun insertPlaylistIntoPlaylistLove(
        userId: String,
        playlistId: Int
    ): DataResult<Boolean> {
        return try {
            val response = remote.insertPlaylistIntoPlaylistLove(userId, playlistId)
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

    override suspend fun deleteSongLove(songLoveId: Int): DataResult<Boolean> {
        return try {
            val response = remote.deleteSongLove(songLoveId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(true)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }

    override suspend fun getListSongLocal(): LiveData<ArrayList<Song>> {
        return try {
            local.getListSongLocal()
        } catch (e: Exception) {
            MutableLiveData()
        }
    }

    override  suspend fun getListListenAgain(userID: String): DataResult<ArrayList<SongAgain>> {
        return try {
            val response = remote.getListSongAgain(userID)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(response.body()!!.songAgain)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }

    }

    override suspend fun getListSongTopic(id: Int): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSongTopic(id)
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSongTopic", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getListSongPlaylist(id: Int): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSongPlaylist(id)
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSongPlaylist", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getListSongAlbum(id: Int): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSongAlbum(id)
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSongAlbum", e)
            DataResult.Error(e)
        }
    }


    override suspend fun getListSongPlaylistUser(id: Int): DataResult<ArrayList<Song>> {
        return try {
            val response = remote.getListSongPlaylistUser(id)
            if (response.isSuccessful && response.body() != null) {
                val body = response.body()!!
                if (body.status == Constant.STATUS && body.songs != null) {
                    DataResult.Success(sanitizeSongImages(body.songs))
                } else {
                    android.util.Log.e("MusicRepository", "Invalid status or null songs: status=${body.status}")
                    DataResult.Failure(Constant.CALL_API_ERROR + "status=${body.status}")
                }
            } else {
                android.util.Log.e("MusicRepository", "Response not successful: code=${response.code()}")
                DataResult.Failure(Constant.CALL_API_ERROR + response.code())
            }
        } catch (e: Exception) {
            android.util.Log.e("MusicRepository", "Exception in getListSongPlaylistUser", e)
            DataResult.Error(e)
        }
    }

    override suspend fun getLyricsBySongId(songId: Int): DataResult<ArrayList<Lyric>> {
        return try {
            val response = remote.getLyricsBySongId(songId)
            if (response.body() != null && response.body()!!.status == Constant.STATUS) {
                DataResult.Success(response.body()!!.lyrics)
            } else {
                DataResult.Failure(Constant.CALL_API_ERROR)
            }
        } catch (e: Exception) {
            DataResult.Error(e)
        }
    }
}