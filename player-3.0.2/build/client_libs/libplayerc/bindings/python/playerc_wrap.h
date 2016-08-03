
typedef struct
{
    int *actual;
} intArray;

typedef struct
{
    double *actual;
} doubleArray;

typedef struct
{
    float *actual;
} floatArray;


#ifndef PLAYERC_H
#define PLAYERC_H

#if !defined (WIN32)
  #include <netinet/in.h> 
#endif
#include <stddef.h> 
#include <stdio.h>

#include <playerconfig.h>

#include <libplayercommon/playercommon.h>
#include <libplayerinterface/player.h>
#include <libplayercommon/playercommon.h>
#include <libplayerinterface/interface_util.h>
#include <libplayerinterface/playerxdr.h>
#include <libplayerinterface/functiontable.h>
#include <libplayerwkb/playerwkb.h>
#if defined (WIN32)
  #include <winsock2.h>
#endif

#ifndef MIN
  #define MIN(a,b) ((a < b) ? a : b)
#endif
#ifndef MAX
  #define MAX(a,b) ((a > b) ? a : b)
#endif

#if defined (WIN32)
  #if defined (PLAYER_STATIC)
    #define PLAYERC_EXPORT
  #elif defined (playerc_EXPORTS)
    #define PLAYERC_EXPORT    __declspec (dllexport)
  #else
    #define PLAYERC_EXPORT    __declspec (dllimport)
  #endif
#else
  #define PLAYERC_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define PLAYERC_OPEN_MODE     PLAYER_OPEN_MODE
#define PLAYERC_CLOSE_MODE    PLAYER_CLOSE_MODE
#define PLAYERC_ERROR_MODE    PLAYER_ERROR_MODE

#define PLAYERC_DATAMODE_PUSH PLAYER_DATAMODE_PUSH
#define PLAYERC_DATAMODE_PULL PLAYER_DATAMODE_PULL

#define PLAYERC_TRANSPORT_TCP 1
#define PLAYERC_TRANSPORT_UDP 2

#define PLAYERC_QUEUE_RING_SIZE 512

PLAYERC_EXPORT const char *playerc_error_str(void);

PLAYERC_EXPORT int playerc_add_xdr_ftable(playerxdr_function_t *flist, int replace);

struct _playerc_client_t;
struct _playerc_device_t;

struct pollfd;

typedef struct
{
  player_msghdr_t header;
  void *data;
} playerc_client_item_t;

typedef struct
{
  
  int client_count;
  struct _playerc_client_t *client[128];

  struct pollfd* pollfd;

  double time;

} playerc_mclient_t;

PLAYERC_EXPORT playerc_mclient_t *playerc_mclient_create(void);

PLAYERC_EXPORT void playerc_mclient_destroy(playerc_mclient_t *mclient);

PLAYERC_EXPORT int playerc_mclient_addclient(playerc_mclient_t *mclient, struct _playerc_client_t *client);

PLAYERC_EXPORT int playerc_mclient_peek(playerc_mclient_t *mclient, int timeout);

PLAYERC_EXPORT int playerc_mclient_read(playerc_mclient_t *mclient, int timeout);

PLAYERC_EXPORT typedef void (*playerc_putmsg_fn_t) (void *device, char *header, char *data);

PLAYERC_EXPORT typedef void (*playerc_callback_fn_t) (void *data);

typedef struct
{
  
  player_devaddr_t addr;

  char drivername[PLAYER_MAX_DRIVER_STRING_LEN];

} playerc_device_info_t;

typedef struct _playerc_client_t
{
  
  void *id;

  char *host;
  int port;
  int transport;
  struct sockaddr_in server;

  int connected;

  int retry_limit;

  double retry_time;

  uint32_t overflow_count;

  int sock;

  uint8_t mode;

  int data_requested;

  int data_received;

  playerc_device_info_t devinfos[PLAYER_MAX_DEVICES];
  int devinfo_count;

  struct _playerc_device_t *device[PLAYER_MAX_DEVICES];
  int device_count;

  playerc_client_item_t qitems[PLAYERC_QUEUE_RING_SIZE];
  int qfirst, qlen, qsize;

  char *data;
  char *write_xdrdata;
  char *read_xdrdata;
  size_t read_xdrdata_len;

  double datatime;
  
  double lasttime;

  double request_timeout;

} playerc_client_t;

PLAYERC_EXPORT playerc_client_t *playerc_client_create(playerc_mclient_t *mclient,
                                        const char *host, int port);

PLAYERC_EXPORT void playerc_client_destroy(playerc_client_t *client);

PLAYERC_EXPORT void playerc_client_set_transport(playerc_client_t* client,
                                  unsigned int transport);

PLAYERC_EXPORT int playerc_client_connect(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_disconnect(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_disconnect_retry(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_datamode(playerc_client_t *client, uint8_t mode);

PLAYERC_EXPORT int playerc_client_requestdata(playerc_client_t* client);

PLAYERC_EXPORT int playerc_client_set_replace_rule(playerc_client_t *client, int interf, int index, int type, int subtype, int replace);

PLAYERC_EXPORT int playerc_client_adddevice(playerc_client_t *client, struct _playerc_device_t *device);

PLAYERC_EXPORT int playerc_client_deldevice(playerc_client_t *client, struct _playerc_device_t *device);

PLAYERC_EXPORT int  playerc_client_addcallback(playerc_client_t *client, struct _playerc_device_t *device,
                                playerc_callback_fn_t callback, void *data);

PLAYERC_EXPORT int  playerc_client_delcallback(playerc_client_t *client, struct _playerc_device_t *device,
                                playerc_callback_fn_t callback, void *data);

PLAYERC_EXPORT int playerc_client_get_devlist(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_subscribe(playerc_client_t *client, int code, int index,
                             int access, char *drivername, size_t len);

PLAYERC_EXPORT int playerc_client_unsubscribe(playerc_client_t *client, int code, int index);

PLAYERC_EXPORT int playerc_client_request(playerc_client_t *client,
                           struct _playerc_device_t *device, uint8_t reqtype,
                           const void *req_data, void **rep_data);

PLAYERC_EXPORT int playerc_client_peek(playerc_client_t *client, int timeout);

PLAYERC_EXPORT int playerc_client_internal_peek(playerc_client_t *client, int timeout);

PLAYERC_EXPORT void *playerc_client_read(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_read_nonblock(playerc_client_t *client);

PLAYERC_EXPORT int playerc_client_read_nonblock_withproxy(playerc_client_t *client, void ** proxy);

PLAYERC_EXPORT void playerc_client_set_request_timeout(playerc_client_t* client, uint32_t seconds);

PLAYERC_EXPORT void playerc_client_set_retry_limit(playerc_client_t* client, int limit);

PLAYERC_EXPORT void playerc_client_set_retry_time(playerc_client_t* client, double time);

PLAYERC_EXPORT int playerc_client_write(playerc_client_t *client,
                         struct _playerc_device_t *device,
                         uint8_t subtype,
                         void *cmd, double* timestamp);

typedef struct _playerc_device_t
{
  
  void *id;

  playerc_client_t *client;

  player_devaddr_t addr;

  char drivername[PLAYER_MAX_DRIVER_STRING_LEN];

  int subscribed;

  double datatime;

  double lasttime;

  int fresh;
  
  int freshgeom;
  
  int freshconfig;

  playerc_putmsg_fn_t putmsg;

  void *user_data;

  int callback_count;
  playerc_callback_fn_t callback[4];
  void *callback_data[4];

} playerc_device_t;

PLAYERC_EXPORT void playerc_device_init(playerc_device_t *device, playerc_client_t *client,
                         int code, int index, playerc_putmsg_fn_t putmsg);

PLAYERC_EXPORT void playerc_device_term(playerc_device_t *device);

PLAYERC_EXPORT int playerc_device_subscribe(playerc_device_t *device, int access);

PLAYERC_EXPORT int playerc_device_unsubscribe(playerc_device_t *device);

PLAYERC_EXPORT int playerc_device_hascapability(playerc_device_t *device, uint32_t type, uint32_t subtype);

PLAYERC_EXPORT int playerc_device_get_boolprop(playerc_device_t *device, char *property, BOOL *value);

PLAYERC_EXPORT int playerc_device_set_boolprop(playerc_device_t *device, char *property, BOOL value);

PLAYERC_EXPORT int playerc_device_get_intprop(playerc_device_t *device, char *property, int32_t *value);

PLAYERC_EXPORT int playerc_device_set_intprop(playerc_device_t *device, char *property, int32_t value);

PLAYERC_EXPORT int playerc_device_get_dblprop(playerc_device_t *device, char *property, double *value);

PLAYERC_EXPORT int playerc_device_set_dblprop(playerc_device_t *device, char *property, double value);

PLAYERC_EXPORT int playerc_device_get_strprop(playerc_device_t *device, char *property, char **value);

PLAYERC_EXPORT int playerc_device_set_strprop(playerc_device_t *device, char *property, char *value);

typedef struct
{
  
  playerc_device_t info;

  uint8_t voltages_count;

  floatArray voltages;

} playerc_aio_t;

PLAYERC_EXPORT playerc_aio_t *playerc_aio_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_aio_destroy(playerc_aio_t *device);

PLAYERC_EXPORT int playerc_aio_subscribe(playerc_aio_t *device, int access);

PLAYERC_EXPORT int playerc_aio_unsubscribe(playerc_aio_t *device);

PLAYERC_EXPORT int playerc_aio_set_output(playerc_aio_t *device, uint8_t id, float volt);

PLAYERC_EXPORT float playerc_aio_get_data(playerc_aio_t *device, uint32_t index);

#define PLAYERC_ACTARRAY_NUM_ACTUATORS PLAYER_ACTARRAY_NUM_ACTUATORS
#define PLAYERC_ACTARRAY_ACTSTATE_IDLE PLAYER_ACTARRAY_ACTSTATE_IDLE
#define PLAYERC_ACTARRAY_ACTSTATE_MOVING PLAYER_ACTARRAY_ACTSTATE_MOVING
#define PLAYERC_ACTARRAY_ACTSTATE_BRAKED PLAYER_ACTARRAY_ACTSTATE_BRAKED
#define PLAYERC_ACTARRAY_ACTSTATE_STALLED PLAYER_ACTARRAY_ACTSTATE_STALLED
#define PLAYERC_ACTARRAY_TYPE_LINEAR PLAYER_ACTARRAY_TYPE_LINEAR
#define PLAYERC_ACTARRAY_TYPE_ROTARY PLAYER_ACTARRAY_TYPE_ROTARY

typedef struct
{
  
  playerc_device_t info;

  uint32_t actuators_count;
  
  player_actarray_actuator_t *actuators_data;
  
  uint32_t actuators_geom_count;
  player_actarray_actuatorgeom_t *actuators_geom;
  
  uint8_t motor_state;
  
  player_point_3d_t base_pos;
  
  player_orientation_3d_t base_orientation;
} playerc_actarray_t;

PLAYERC_EXPORT playerc_actarray_t *playerc_actarray_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_actarray_destroy(playerc_actarray_t *device);

PLAYERC_EXPORT int playerc_actarray_subscribe(playerc_actarray_t *device, int access);

PLAYERC_EXPORT int playerc_actarray_unsubscribe(playerc_actarray_t *device);

PLAYERC_EXPORT player_actarray_actuator_t playerc_actarray_get_actuator_data(playerc_actarray_t *device, uint32_t index);

PLAYERC_EXPORT player_actarray_actuatorgeom_t playerc_actarray_get_actuator_geom(playerc_actarray_t *device, uint32_t index);

PLAYERC_EXPORT int playerc_actarray_get_geom(playerc_actarray_t *device);

PLAYERC_EXPORT int playerc_actarray_position_cmd(playerc_actarray_t *device, int joint, float position);

PLAYERC_EXPORT int playerc_actarray_multi_position_cmd(playerc_actarray_t *device, float *positions, int positions_count);

PLAYERC_EXPORT int playerc_actarray_speed_cmd(playerc_actarray_t *device, int joint, float speed);

PLAYERC_EXPORT int playerc_actarray_multi_speed_cmd(playerc_actarray_t *device, float *speeds, int speeds_count);

PLAYERC_EXPORT int playerc_actarray_home_cmd(playerc_actarray_t *device, int joint);

PLAYERC_EXPORT int playerc_actarray_current_cmd(playerc_actarray_t *device, int joint, float current);

PLAYERC_EXPORT int playerc_actarray_multi_current_cmd(playerc_actarray_t *device, float *currents, int currents_count);

PLAYERC_EXPORT int playerc_actarray_power(playerc_actarray_t *device, uint8_t enable);

PLAYERC_EXPORT int playerc_actarray_brakes(playerc_actarray_t *device, uint8_t enable);

PLAYERC_EXPORT int playerc_actarray_speed_config(playerc_actarray_t *device, int joint, float speed);

PLAYERC_EXPORT int playerc_actarray_accel_config(playerc_actarray_t *device, int joint, float accel);

typedef struct
{
  
  playerc_device_t info;

  player_audio_mixer_channel_list_detail_t channel_details_list;

  player_audio_wav_t wav_data;

  player_audio_seq_t seq_data;

  player_audio_mixer_channel_list_t mixer_data;

  uint32_t state;

  int last_index;

} playerc_audio_t;

PLAYERC_EXPORT playerc_audio_t *playerc_audio_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_audio_destroy(playerc_audio_t *device);

PLAYERC_EXPORT int playerc_audio_subscribe(playerc_audio_t *device, int access);

PLAYERC_EXPORT int playerc_audio_unsubscribe(playerc_audio_t *device);

PLAYERC_EXPORT int playerc_audio_wav_play_cmd(playerc_audio_t *device, uint32_t data_count, uint8_t data[], uint32_t format);

PLAYERC_EXPORT int playerc_audio_wav_stream_rec_cmd(playerc_audio_t *device, uint8_t state);

PLAYERC_EXPORT int playerc_audio_sample_play_cmd(playerc_audio_t *device, int index);

PLAYERC_EXPORT int playerc_audio_seq_play_cmd(playerc_audio_t *device, player_audio_seq_t * tones);

PLAYERC_EXPORT int playerc_audio_mixer_multchannels_cmd(playerc_audio_t *device, player_audio_mixer_channel_list_t * levels);

PLAYERC_EXPORT int playerc_audio_mixer_channel_cmd(playerc_audio_t *device, uint32_t index, float amplitude, uint8_t active);

PLAYERC_EXPORT int playerc_audio_wav_rec(playerc_audio_t *device);

PLAYERC_EXPORT int playerc_audio_sample_load(playerc_audio_t *device, int index, uint32_t data_count, uint8_t data[], uint32_t format);

PLAYERC_EXPORT int playerc_audio_sample_retrieve(playerc_audio_t *device, int index);

PLAYERC_EXPORT int playerc_audio_sample_rec(playerc_audio_t *device, int index, uint32_t length);

PLAYERC_EXPORT int playerc_audio_get_mixer_levels(playerc_audio_t *device);

PLAYERC_EXPORT int playerc_audio_get_mixer_details(playerc_audio_t *device);

#define PLAYERC_BLACKBOARD_DATA_TYPE_NONE       0
#define PLAYERC_BLACKBOARD_DATA_TYPE_SIMPLE     1
#define PLAYERC_BLACKBOARD_DATA_TYPE_COMPLEX    2

#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_NONE    0
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_STRING  1
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_INT     2
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_DOUBLE  3

typedef struct playerc_blackboard
{
  
  playerc_device_t info;
  
  void (*on_blackboard_event)(struct playerc_blackboard*, player_blackboard_entry_t);
  
  void *py_private;
} playerc_blackboard_t;

PLAYERC_EXPORT playerc_blackboard_t *playerc_blackboard_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_blackboard_destroy(playerc_blackboard_t *device);

PLAYERC_EXPORT int playerc_blackboard_subscribe(playerc_blackboard_t *device, int access);

PLAYERC_EXPORT int playerc_blackboard_unsubscribe(playerc_blackboard_t *device);

PLAYERC_EXPORT int playerc_blackboard_subscribe_to_key(playerc_blackboard_t *device, const char* key, const char* group, player_blackboard_entry_t** entry);

PLAYERC_EXPORT int playerc_blackboard_get_entry(playerc_blackboard_t *device, const char* key, const char* group, player_blackboard_entry_t** entry);

PLAYERC_EXPORT int playerc_blackboard_unsubscribe_from_key(playerc_blackboard_t *device, const char* key, const char* group);

PLAYERC_EXPORT int playerc_blackboard_subscribe_to_group(playerc_blackboard_t *device, const char* group);

PLAYERC_EXPORT int playerc_blackboard_unsubscribe_from_group(playerc_blackboard_t *device, const char* group);

PLAYERC_EXPORT int playerc_blackboard_set_entry(playerc_blackboard_t *device, player_blackboard_entry_t* entry);

PLAYERC_EXPORT int playerc_blackboard_set_string(playerc_blackboard_t *device, const char* key, const char* group, const char* value);

PLAYERC_EXPORT int playerc_blackboard_set_int(playerc_blackboard_t *device, const char* key, const char* group, const int value);

PLAYERC_EXPORT int playerc_blackboard_set_double(playerc_blackboard_t *device, const char* key, const char* group, const double value);

typedef struct
{
  
  playerc_device_t info;

  uint32_t enabled;
  double duty_cycle;
  double period;
  uint8_t red, green, blue;
} playerc_blinkenlight_t;

PLAYERC_EXPORT playerc_blinkenlight_t *playerc_blinkenlight_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_blinkenlight_destroy(playerc_blinkenlight_t *device);

PLAYERC_EXPORT int playerc_blinkenlight_subscribe(playerc_blinkenlight_t *device, int access);

PLAYERC_EXPORT int playerc_blinkenlight_unsubscribe(playerc_blinkenlight_t *device);

PLAYERC_EXPORT int playerc_blinkenlight_enable( playerc_blinkenlight_t *device,
				 uint32_t enable );

PLAYERC_EXPORT int playerc_blinkenlight_color( playerc_blinkenlight_t *device,
				uint32_t id,
				uint8_t red,
				uint8_t green,
				uint8_t blue );

PLAYERC_EXPORT int playerc_blinkenlight_blink( playerc_blinkenlight_t *device,
				uint32_t id,
				float period,
				float duty_cycle );

typedef player_blobfinder_blob_t playerc_blobfinder_blob_t;

typedef struct
{
  
  playerc_device_t info;

  unsigned int width, height;

  unsigned int blobs_count;
  playerc_blobfinder_blob_t *blobs;

} playerc_blobfinder_t;

PLAYERC_EXPORT playerc_blobfinder_t *playerc_blobfinder_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_blobfinder_destroy(playerc_blobfinder_t *device);

PLAYERC_EXPORT int playerc_blobfinder_subscribe(playerc_blobfinder_t *device, int access);

PLAYERC_EXPORT int playerc_blobfinder_unsubscribe(playerc_blobfinder_t *device);

typedef struct
{
  
  playerc_device_t info;

  int pose_count;

  player_bumper_define_t *poses;

  int bumper_count;

  uint8_t *bumpers;

} playerc_bumper_t;

PLAYERC_EXPORT playerc_bumper_t *playerc_bumper_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_bumper_destroy(playerc_bumper_t *device);

PLAYERC_EXPORT int playerc_bumper_subscribe(playerc_bumper_t *device, int access);

PLAYERC_EXPORT int playerc_bumper_unsubscribe(playerc_bumper_t *device);

PLAYERC_EXPORT int playerc_bumper_get_geom(playerc_bumper_t *device);

typedef struct
{
  
  playerc_device_t info;

  int width, height;

  int bpp;

  int format;

  int fdiv;

  int compression;

  int image_count;

  uint8_t *image;

} playerc_camera_t;

PLAYERC_EXPORT playerc_camera_t *playerc_camera_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_camera_destroy(playerc_camera_t *device);

PLAYERC_EXPORT int playerc_camera_subscribe(playerc_camera_t *device, int access);

PLAYERC_EXPORT int playerc_camera_unsubscribe(playerc_camera_t *device);

PLAYERC_EXPORT void playerc_camera_decompress(playerc_camera_t *device);

PLAYERC_EXPORT void playerc_camera_save(playerc_camera_t *device, const char *filename);

typedef struct
{
  
  playerc_device_t info;

    uint8_t count;

    uint32_t digin;

} playerc_dio_t;

PLAYERC_EXPORT playerc_dio_t *playerc_dio_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_dio_destroy(playerc_dio_t *device);

PLAYERC_EXPORT int playerc_dio_subscribe(playerc_dio_t *device, int access);

PLAYERC_EXPORT int playerc_dio_unsubscribe(playerc_dio_t *device);

PLAYERC_EXPORT int playerc_dio_set_output(playerc_dio_t *device, uint8_t output_count, uint32_t digout);

typedef struct
{
  
  playerc_device_t info;

  player_fiducial_geom_t fiducial_geom;

  int fiducials_count;
  player_fiducial_item_t *fiducials;

} playerc_fiducial_t;

PLAYERC_EXPORT playerc_fiducial_t *playerc_fiducial_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_fiducial_destroy(playerc_fiducial_t *device);

PLAYERC_EXPORT int playerc_fiducial_subscribe(playerc_fiducial_t *device, int access);

PLAYERC_EXPORT int playerc_fiducial_unsubscribe(playerc_fiducial_t *device);

PLAYERC_EXPORT int playerc_fiducial_get_geom(playerc_fiducial_t *device);

typedef struct
{
  
  playerc_device_t info;

  double utc_time;

  double lat, lon;

  double alt;

  double utm_e, utm_n;

  double hdop;

  double vdop;

  double err_horz, err_vert;

  int quality;

  int sat_count;

} playerc_gps_t;

PLAYERC_EXPORT playerc_gps_t *playerc_gps_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_gps_destroy(playerc_gps_t *device);

PLAYERC_EXPORT int playerc_gps_subscribe(playerc_gps_t *device, int access);

PLAYERC_EXPORT int playerc_gps_unsubscribe(playerc_gps_t *device);

typedef struct
{
  
  playerc_device_t info;

  player_color_t color;

} playerc_graphics2d_t;

PLAYERC_EXPORT playerc_graphics2d_t *playerc_graphics2d_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_graphics2d_destroy(playerc_graphics2d_t *device);

PLAYERC_EXPORT int playerc_graphics2d_subscribe(playerc_graphics2d_t *device, int access);

PLAYERC_EXPORT int playerc_graphics2d_unsubscribe(playerc_graphics2d_t *device);

PLAYERC_EXPORT int playerc_graphics2d_setcolor(playerc_graphics2d_t *device,
                                player_color_t col );

PLAYERC_EXPORT int playerc_graphics2d_draw_points(playerc_graphics2d_t *device,
           player_point_2d_t pts[],
           int count );

PLAYERC_EXPORT int playerc_graphics2d_draw_polyline(playerc_graphics2d_t *device,
             player_point_2d_t pts[],
             int count );

PLAYERC_EXPORT int playerc_graphics2d_draw_polygon(playerc_graphics2d_t *device,
            player_point_2d_t pts[],
            int count,
            int filled,
            player_color_t fill_color );

PLAYERC_EXPORT int playerc_graphics2d_clear(playerc_graphics2d_t *device );

typedef struct
{
  
  playerc_device_t info;

  player_color_t color;

} playerc_graphics3d_t;

PLAYERC_EXPORT playerc_graphics3d_t *playerc_graphics3d_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_graphics3d_destroy(playerc_graphics3d_t *device);

PLAYERC_EXPORT int playerc_graphics3d_subscribe(playerc_graphics3d_t *device, int access);

PLAYERC_EXPORT int playerc_graphics3d_unsubscribe(playerc_graphics3d_t *device);

PLAYERC_EXPORT int playerc_graphics3d_setcolor(playerc_graphics3d_t *device,
                                player_color_t col );

PLAYERC_EXPORT int playerc_graphics3d_draw(playerc_graphics3d_t *device,
           player_graphics3d_draw_mode_t mode,
           player_point_3d_t pts[],
           int count );

PLAYERC_EXPORT int playerc_graphics3d_clear(playerc_graphics3d_t *device );

PLAYERC_EXPORT int playerc_graphics3d_translate(playerc_graphics3d_t *device,
				 double x, double y, double z );

PLAYERC_EXPORT int playerc_graphics3d_rotate( playerc_graphics3d_t *device,
			       double a, double x, double y, double z );

typedef struct
{
  
  playerc_device_t info;

  player_pose3d_t pose;
  player_bbox3d_t outer_size;
  player_bbox3d_t inner_size;
  
  uint8_t num_beams;
  
  uint8_t capacity;

  uint8_t state;
  
  uint32_t beams;
  
  uint8_t stored;
} playerc_gripper_t;

PLAYERC_EXPORT playerc_gripper_t *playerc_gripper_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_gripper_destroy(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_subscribe(playerc_gripper_t *device, int access);

PLAYERC_EXPORT int playerc_gripper_unsubscribe(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_open_cmd(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_close_cmd(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_stop_cmd(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_store_cmd(playerc_gripper_t *device);

PLAYERC_EXPORT int playerc_gripper_retrieve_cmd(playerc_gripper_t *device);

PLAYERC_EXPORT void playerc_gripper_printout(playerc_gripper_t *device, const char* prefix);

PLAYERC_EXPORT int playerc_gripper_get_geom(playerc_gripper_t *device);

typedef struct
{
    
    playerc_device_t info;
    
    player_health_cpu_t cpu_usage;
    
    player_health_memory_t mem;
    
    player_health_memory_t swap;
} playerc_health_t;

PLAYERC_EXPORT playerc_health_t *playerc_health_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_health_destroy(playerc_health_t *device);

PLAYERC_EXPORT int playerc_health_subscribe(playerc_health_t *device, int access);

PLAYERC_EXPORT int playerc_health_unsubscribe(playerc_health_t *device);

typedef struct
{
  
  playerc_device_t info;

  player_ir_data_t data;

  player_ir_pose_t poses;

} playerc_ir_t;

PLAYERC_EXPORT playerc_ir_t *playerc_ir_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_ir_destroy(playerc_ir_t *device);

PLAYERC_EXPORT int playerc_ir_subscribe(playerc_ir_t *device, int access);

PLAYERC_EXPORT int playerc_ir_unsubscribe(playerc_ir_t *device);

PLAYERC_EXPORT int playerc_ir_get_geom(playerc_ir_t *device);

typedef struct
{
  
  playerc_device_t info;
  int32_t axes_count;
  int32_t pos[8];
  uint32_t buttons;
  intArray axes_max;
  intArray axes_min;
  doubleArray scale_pos;

} playerc_joystick_t;

PLAYERC_EXPORT playerc_joystick_t *playerc_joystick_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_joystick_destroy(playerc_joystick_t *device);

PLAYERC_EXPORT int playerc_joystick_subscribe(playerc_joystick_t *device, int access);

PLAYERC_EXPORT int playerc_joystick_unsubscribe(playerc_joystick_t *device);

typedef struct
{
  
  playerc_device_t info;

  double pose[3];
  double size[2];

  double robot_pose[3];

  int intensity_on;

  int scan_count;

  double scan_start;

  double scan_res;

  double range_res;

  double max_range;

  double scanning_frequency;

  doubleArray ranges;

  double (*scan)[2];

  player_point_2d_t *point;

  intArray intensity;

  int scan_id;

  int laser_id;

  double min_right;

  double min_left;
} playerc_laser_t;

PLAYERC_EXPORT playerc_laser_t *playerc_laser_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_laser_destroy(playerc_laser_t *device);

PLAYERC_EXPORT int playerc_laser_subscribe(playerc_laser_t *device, int access);

PLAYERC_EXPORT int playerc_laser_unsubscribe(playerc_laser_t *device);

PLAYERC_EXPORT int playerc_laser_set_config(playerc_laser_t *device,
                             double min_angle, double max_angle,
                             double resolution,
                             double range_res,
                             unsigned char intensity,
                             double scanning_frequency);

PLAYERC_EXPORT int playerc_laser_get_config(playerc_laser_t *device,
                             double *min_angle,
                             double *max_angle,
                             double *resolution,
                             double *range_res,
                             unsigned char *intensity,
                             double *scanning_frequency);

PLAYERC_EXPORT int playerc_laser_get_geom(playerc_laser_t *device);

PLAYERC_EXPORT int playerc_laser_get_id (playerc_laser_t *device);

PLAYERC_EXPORT void playerc_laser_printout( playerc_laser_t * device,
        const char* prefix );

typedef struct
{
  
  playerc_device_t info;

  player_limb_data_t data;
  player_limb_geom_req_t geom;
} playerc_limb_t;

PLAYERC_EXPORT playerc_limb_t *playerc_limb_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_limb_destroy(playerc_limb_t *device);

PLAYERC_EXPORT int playerc_limb_subscribe(playerc_limb_t *device, int access);

PLAYERC_EXPORT int playerc_limb_unsubscribe(playerc_limb_t *device);

PLAYERC_EXPORT int playerc_limb_get_geom(playerc_limb_t *device);

PLAYERC_EXPORT int playerc_limb_home_cmd(playerc_limb_t *device);

PLAYERC_EXPORT int playerc_limb_stop_cmd(playerc_limb_t *device);

PLAYERC_EXPORT int playerc_limb_setpose_cmd(playerc_limb_t *device, float pX, float pY, float pZ, float aX, float aY, float aZ, float oX, float oY, float oZ);

PLAYERC_EXPORT int playerc_limb_setposition_cmd(playerc_limb_t *device, float pX, float pY, float pZ);

PLAYERC_EXPORT int playerc_limb_vecmove_cmd(playerc_limb_t *device, float x, float y, float z, float length);

PLAYERC_EXPORT int playerc_limb_power(playerc_limb_t *device, uint32_t enable);

PLAYERC_EXPORT int playerc_limb_brakes(playerc_limb_t *device, uint32_t enable);

PLAYERC_EXPORT int playerc_limb_speed_config(playerc_limb_t *device, float speed);

typedef struct playerc_localize_particle
{
  double pose[3];
  double weight;
} playerc_localize_particle_t;

typedef struct
{
  
  playerc_device_t info;

  int map_size_x, map_size_y;

  double map_scale;

  int map_tile_x, map_tile_y;

  int8_t *map_cells;

  int pending_count;

  double pending_time;

  int hypoth_count;
  player_localize_hypoth_t *hypoths;

  double mean[3];
  double variance;
  int num_particles;
  playerc_localize_particle_t *particles;

} playerc_localize_t;

PLAYERC_EXPORT playerc_localize_t *playerc_localize_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_localize_destroy(playerc_localize_t *device);

PLAYERC_EXPORT int playerc_localize_subscribe(playerc_localize_t *device, int access);

PLAYERC_EXPORT int playerc_localize_unsubscribe(playerc_localize_t *device);

PLAYERC_EXPORT int playerc_localize_set_pose(playerc_localize_t *device, double pose[3], double cov[3]);

PLAYERC_EXPORT int playerc_localize_get_particles(playerc_localize_t *device);

typedef struct
{
  
  playerc_device_t info;

  int type;

  int state;
} playerc_log_t;

PLAYERC_EXPORT playerc_log_t *playerc_log_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_log_destroy(playerc_log_t *device);

PLAYERC_EXPORT int playerc_log_subscribe(playerc_log_t *device, int access);

PLAYERC_EXPORT int playerc_log_unsubscribe(playerc_log_t *device);

PLAYERC_EXPORT int playerc_log_set_write_state(playerc_log_t* device, int state);

PLAYERC_EXPORT int playerc_log_set_read_state(playerc_log_t* device, int state);

PLAYERC_EXPORT int playerc_log_set_read_rewind(playerc_log_t* device);

PLAYERC_EXPORT int playerc_log_get_state(playerc_log_t* device);

PLAYERC_EXPORT int playerc_log_set_filename(playerc_log_t* device, const char* fname);

typedef struct
{
  
  playerc_device_t info;

  double resolution;

  int width, height;

  double origin[2];

  char* cells;

  double vminx, vminy, vmaxx, vmaxy;
  int num_segments;
  player_segment_t* segments;
} playerc_map_t;

#define PLAYERC_MAP_INDEX(dev, i, j) ((dev->width) * (j) + (i))

PLAYERC_EXPORT playerc_map_t *playerc_map_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_map_destroy(playerc_map_t *device);

PLAYERC_EXPORT int playerc_map_subscribe(playerc_map_t *device, int access);

PLAYERC_EXPORT int playerc_map_unsubscribe(playerc_map_t *device);

PLAYERC_EXPORT int playerc_map_get_map(playerc_map_t* device);

PLAYERC_EXPORT int playerc_map_get_vector(playerc_map_t* device);

typedef struct
{
  
  playerc_device_t info;
  
  uint32_t srid;
  
  player_extent2d_t extent;
  
  uint32_t layers_count;
  
  player_vectormap_layer_data_t** layers_data;
  
  player_vectormap_layer_info_t** layers_info;
  
  playerwkbprocessor_t wkbprocessor;

} playerc_vectormap_t;

PLAYERC_EXPORT playerc_vectormap_t *playerc_vectormap_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_vectormap_destroy(playerc_vectormap_t *device);

PLAYERC_EXPORT int playerc_vectormap_subscribe(playerc_vectormap_t *device, int access);

PLAYERC_EXPORT int playerc_vectormap_unsubscribe(playerc_vectormap_t *device);

PLAYERC_EXPORT int playerc_vectormap_get_map_info(playerc_vectormap_t* device);

PLAYERC_EXPORT int playerc_vectormap_get_layer_data(playerc_vectormap_t *device, unsigned layer_index);

PLAYERC_EXPORT int playerc_vectormap_write_layer(playerc_vectormap_t *device, const player_vectormap_layer_data_t * data);

PLAYERC_EXPORT void playerc_vectormap_cleanup(playerc_vectormap_t *device);

PLAYERC_EXPORT uint8_t * playerc_vectormap_get_feature_data(playerc_vectormap_t *device, unsigned layer_index, unsigned feature_index);
PLAYERC_EXPORT size_t playerc_vectormap_get_feature_data_count(playerc_vectormap_t *device, unsigned layer_index, unsigned feature_index);

typedef struct
{
  
  playerc_device_t info;

  int data_count;

  uint8_t *data;
} playerc_opaque_t;

PLAYERC_EXPORT playerc_opaque_t *playerc_opaque_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_opaque_destroy(playerc_opaque_t *device);

PLAYERC_EXPORT int playerc_opaque_subscribe(playerc_opaque_t *device, int access);

PLAYERC_EXPORT int playerc_opaque_unsubscribe(playerc_opaque_t *device);

PLAYERC_EXPORT int playerc_opaque_cmd(playerc_opaque_t *device, player_opaque_data_t *data);

PLAYERC_EXPORT int playerc_opaque_req(playerc_opaque_t *device, player_opaque_data_t *request, player_opaque_data_t **reply);

typedef struct
{
  
  playerc_device_t info;

  int path_valid;

  int path_done;

  double px, py, pa;

  double gx, gy, ga;

  double wx, wy, wa;

  int curr_waypoint;

  int waypoint_count;

  double (*waypoints)[3];

} playerc_planner_t;

PLAYERC_EXPORT playerc_planner_t *playerc_planner_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_planner_destroy(playerc_planner_t *device);

PLAYERC_EXPORT int playerc_planner_subscribe(playerc_planner_t *device, int access);

PLAYERC_EXPORT int playerc_planner_unsubscribe(playerc_planner_t *device);

PLAYERC_EXPORT int playerc_planner_set_cmd_pose(playerc_planner_t *device,
                                  double gx, double gy, double ga);

PLAYERC_EXPORT int playerc_planner_get_waypoints(playerc_planner_t *device);

PLAYERC_EXPORT int playerc_planner_enable(playerc_planner_t *device, int state);

typedef struct
{
  
  playerc_device_t info;

  double pose[3];
  double size[2];

  double pos;

  double vel;

  int stall;

  int status;

} playerc_position1d_t;

PLAYERC_EXPORT playerc_position1d_t *playerc_position1d_create(playerc_client_t *client,
                                                int index);

PLAYERC_EXPORT void playerc_position1d_destroy(playerc_position1d_t *device);

PLAYERC_EXPORT int playerc_position1d_subscribe(playerc_position1d_t *device, int access);

PLAYERC_EXPORT int playerc_position1d_unsubscribe(playerc_position1d_t *device);

PLAYERC_EXPORT int playerc_position1d_enable(playerc_position1d_t *device, int enable);

PLAYERC_EXPORT int playerc_position1d_get_geom(playerc_position1d_t *device);

PLAYERC_EXPORT int playerc_position1d_set_cmd_vel(playerc_position1d_t *device,
                                   double vel, int state);

PLAYERC_EXPORT int playerc_position1d_set_cmd_pos(playerc_position1d_t *device,
                                   double pos, int state);

PLAYERC_EXPORT int playerc_position1d_set_cmd_pos_with_vel(playerc_position1d_t *device,
                                            double pos, double vel, int state);

PLAYERC_EXPORT int playerc_position1d_set_odom(playerc_position1d_t *device,
                                double odom);

typedef struct
{
  
  playerc_device_t info;

  double pose[3];
  double size[2];

  double px, py, pa;

  double vx, vy, va;

  int stall;

} playerc_position2d_t;

PLAYERC_EXPORT playerc_position2d_t *playerc_position2d_create(playerc_client_t *client,
                                                int index);

PLAYERC_EXPORT void playerc_position2d_destroy(playerc_position2d_t *device);

PLAYERC_EXPORT int playerc_position2d_subscribe(playerc_position2d_t *device, int access);

PLAYERC_EXPORT int playerc_position2d_unsubscribe(playerc_position2d_t *device);

PLAYERC_EXPORT int playerc_position2d_enable(playerc_position2d_t *device, int enable);

PLAYERC_EXPORT int playerc_position2d_get_geom(playerc_position2d_t *device);

PLAYERC_EXPORT int playerc_position2d_set_cmd_vel(playerc_position2d_t *device,
                                   double vx, double vy, double va, int state);

PLAYERC_EXPORT int playerc_position2d_set_cmd_pose_with_vel(playerc_position2d_t *device,
                                             player_pose2d_t pos,
                                             player_pose2d_t vel,
                                             int state);

PLAYERC_EXPORT int playerc_position2d_set_cmd_vel_head(playerc_position2d_t *device,
                                   double vx, double vy, double pa, int state);

PLAYERC_EXPORT int playerc_position2d_set_cmd_pose(playerc_position2d_t *device,
                                    double gx, double gy, double ga, int state);

PLAYERC_EXPORT int playerc_position2d_set_cmd_car(playerc_position2d_t *device,
                                    double vx, double a);

PLAYERC_EXPORT int playerc_position2d_set_odom(playerc_position2d_t *device,
                                double ox, double oy, double oa);

typedef struct
{
  
  playerc_device_t info;

  double pose[3];
  double size[2];

  double pos_x, pos_y, pos_z;

  double pos_roll, pos_pitch, pos_yaw;

  double vel_x, vel_y, vel_z;

  double vel_roll, vel_pitch, vel_yaw;

  int stall;

} playerc_position3d_t;

PLAYERC_EXPORT playerc_position3d_t *playerc_position3d_create(playerc_client_t *client,
                                                int index);

PLAYERC_EXPORT void playerc_position3d_destroy(playerc_position3d_t *device);

PLAYERC_EXPORT int playerc_position3d_subscribe(playerc_position3d_t *device, int access);

PLAYERC_EXPORT int playerc_position3d_unsubscribe(playerc_position3d_t *device);

PLAYERC_EXPORT int playerc_position3d_enable(playerc_position3d_t *device, int enable);

PLAYERC_EXPORT int playerc_position3d_get_geom(playerc_position3d_t *device);

PLAYERC_EXPORT int playerc_position3d_set_velocity(playerc_position3d_t *device,
                                    double vx, double vy, double vz,
                                    double vr, double vp, double vt,
                                    int state);

PLAYERC_EXPORT int playerc_position3d_set_speed(playerc_position3d_t *device,
                                 double vx, double vy, double vz, int state);

PLAYERC_EXPORT int playerc_position3d_set_pose(playerc_position3d_t *device,
                                double gx, double gy, double gz,
                                double gr, double gp, double gt);

PLAYERC_EXPORT int playerc_position3d_set_pose_with_vel(playerc_position3d_t *device,
                                         player_pose3d_t pos,
                                         player_pose3d_t vel);

PLAYERC_EXPORT int playerc_position3d_set_cmd_pose(playerc_position3d_t *device,
                                    double gx, double gy, double gz);

PLAYERC_EXPORT int playerc_position3d_set_vel_mode(playerc_position3d_t *device, int mode);

PLAYERC_EXPORT int playerc_position3d_set_odom(playerc_position3d_t *device,
                                double ox, double oy, double oz,
                                double oroll, double opitch, double oyaw);

PLAYERC_EXPORT int playerc_position3d_reset_odom(playerc_position3d_t *device);

typedef struct
{
  
  playerc_device_t info;

  int valid;

  double charge;

  double percent;

  double joules;

  double watts;

  int charging;

} playerc_power_t;

PLAYERC_EXPORT playerc_power_t *playerc_power_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_power_destroy(playerc_power_t *device);

PLAYERC_EXPORT int playerc_power_subscribe(playerc_power_t *device, int access);

PLAYERC_EXPORT int playerc_power_unsubscribe(playerc_power_t *device);

typedef struct
{
  
  playerc_device_t info;

  double pan, tilt;

  double zoom;

  int status;
} playerc_ptz_t;

PLAYERC_EXPORT playerc_ptz_t *playerc_ptz_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_ptz_destroy(playerc_ptz_t *device);

PLAYERC_EXPORT int playerc_ptz_subscribe(playerc_ptz_t *device, int access);

PLAYERC_EXPORT int playerc_ptz_unsubscribe(playerc_ptz_t *device);

PLAYERC_EXPORT int playerc_ptz_set(playerc_ptz_t *device, double pan, double tilt, double zoom);

PLAYERC_EXPORT int playerc_ptz_query_status(playerc_ptz_t *device);

PLAYERC_EXPORT int playerc_ptz_set_ws(playerc_ptz_t *device, double pan, double tilt, double zoom,
                       double panspeed, double tiltspeed);

PLAYERC_EXPORT int playerc_ptz_set_control_mode(playerc_ptz_t *device, int mode);

typedef struct
{
  
  playerc_device_t info;

  uint32_t element_count;

  double min_angle;
  
  double max_angle;
  
  double angular_res;
  
  double min_range;
  
  double max_range;
  
  double range_res;
  
  double frequency;

  player_pose3d_t device_pose;
  player_bbox3d_t device_size;
  
  player_pose3d_t *element_poses;
  player_bbox3d_t *element_sizes;

  uint32_t ranges_count;
  
  doubleArray ranges;

  uint32_t intensities_count;
  
  doubleArray intensities;

  uint32_t bearings_count;
  
  doubleArray bearings;

  uint32_t points_count;
  
  player_point_3d_t *points;

} playerc_ranger_t;

PLAYERC_EXPORT playerc_ranger_t *playerc_ranger_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_ranger_destroy(playerc_ranger_t *device);

PLAYERC_EXPORT int playerc_ranger_subscribe(playerc_ranger_t *device, int access);

PLAYERC_EXPORT int playerc_ranger_unsubscribe(playerc_ranger_t *device);

PLAYERC_EXPORT int playerc_ranger_get_geom(playerc_ranger_t *device);

PLAYERC_EXPORT int playerc_ranger_power_config(playerc_ranger_t *device, uint8_t value);

PLAYERC_EXPORT int playerc_ranger_intns_config(playerc_ranger_t *device, uint8_t value);

PLAYERC_EXPORT int playerc_ranger_set_config(playerc_ranger_t *device, double min_angle,
                              double max_angle, double angular_res,
                              double min_range, double max_range,
                              double range_res, double frequency);

PLAYERC_EXPORT int playerc_ranger_get_config(playerc_ranger_t *device, double *min_angle,
                              double *max_angle, double *angular_res,
                              double *min_range, double *max_range,
                              double *range_res, double *frequency);

typedef struct
{
  
  playerc_device_t info;

  int pose_count;

  player_pose3d_t *poses;

  int scan_count;

  doubleArray scan;

} playerc_sonar_t;

PLAYERC_EXPORT playerc_sonar_t *playerc_sonar_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_sonar_destroy(playerc_sonar_t *device);

PLAYERC_EXPORT int playerc_sonar_subscribe(playerc_sonar_t *device, int access);

PLAYERC_EXPORT int playerc_sonar_unsubscribe(playerc_sonar_t *device);

PLAYERC_EXPORT int playerc_sonar_get_geom(playerc_sonar_t *device);

typedef struct
{
  
  uint8_t mac[32];

  uint8_t ip[32];

  uint8_t essid[32];

  int mode;

  int encrypt;

  double freq;

  int qual, level, noise;

} playerc_wifi_link_t;

typedef struct
{
  
  playerc_device_t info;

  playerc_wifi_link_t *links;
  int link_count;
  char ip[32];
} playerc_wifi_t;

PLAYERC_EXPORT playerc_wifi_t *playerc_wifi_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_wifi_destroy(playerc_wifi_t *device);

PLAYERC_EXPORT int playerc_wifi_subscribe(playerc_wifi_t *device, int access);

PLAYERC_EXPORT int playerc_wifi_unsubscribe(playerc_wifi_t *device);

PLAYERC_EXPORT playerc_wifi_link_t *playerc_wifi_get_link(playerc_wifi_t *device, int link);

typedef struct
{
  
  playerc_device_t info;

} playerc_simulation_t;

PLAYERC_EXPORT playerc_simulation_t *playerc_simulation_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_simulation_destroy(playerc_simulation_t *device);

PLAYERC_EXPORT int playerc_simulation_subscribe(playerc_simulation_t *device, int access);

PLAYERC_EXPORT int playerc_simulation_unsubscribe(playerc_simulation_t *device);

PLAYERC_EXPORT int playerc_simulation_set_pose2d(playerc_simulation_t *device, char* name,
                                  double gx, double gy, double ga);

PLAYERC_EXPORT int playerc_simulation_get_pose2d(playerc_simulation_t *device, char* identifier,
				  double *x, double *y, double *a);

PLAYERC_EXPORT int playerc_simulation_set_pose3d(playerc_simulation_t *device, char* name,
				  double gx, double gy, double gz,
				  double groll, double gpitch, double gyaw);

PLAYERC_EXPORT int playerc_simulation_get_pose3d(playerc_simulation_t *device, char* identifier,
				  double *x, double *y, double *z,
				  double *roll, double *pitch, double *yaw, double *time);

PLAYERC_EXPORT int playerc_simulation_set_property(playerc_simulation_t *device,
                                    char* name,
                                    char* property,
                                    void* value,
				    size_t value_len);

PLAYERC_EXPORT int playerc_simulation_get_property(playerc_simulation_t *device,
                                    char* name,
                                    char* property,
                                    void* value,
                                    size_t value_len);

PLAYERC_EXPORT int playerc_simulation_pause(playerc_simulation_t *device );

PLAYERC_EXPORT int playerc_simulation_reset(playerc_simulation_t *device );

PLAYERC_EXPORT int playerc_simulation_save(playerc_simulation_t *device );

typedef struct
{
  
  playerc_device_t info;
} playerc_speech_t;

PLAYERC_EXPORT playerc_speech_t *playerc_speech_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_speech_destroy(playerc_speech_t *device);

PLAYERC_EXPORT int playerc_speech_subscribe(playerc_speech_t *device, int access);

PLAYERC_EXPORT int playerc_speech_unsubscribe(playerc_speech_t *device);

PLAYERC_EXPORT int playerc_speech_say (playerc_speech_t *device, char *);

typedef struct
{
  
  playerc_device_t info;

  char *rawText;
  
  char **words;
  int wordCount;
} playerc_speechrecognition_t;

PLAYERC_EXPORT playerc_speechrecognition_t *playerc_speechrecognition_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_speechrecognition_destroy(playerc_speechrecognition_t *device);

PLAYERC_EXPORT int playerc_speechrecognition_subscribe(playerc_speechrecognition_t *device, int access);

PLAYERC_EXPORT int playerc_speechrecognition_unsubscribe(playerc_speechrecognition_t *device);

typedef struct
{
    
    uint32_t type;
    
    uint32_t guid_count;
    
    uint8_t *guid;
}  playerc_rfidtag_t;

typedef struct
{
  
  playerc_device_t info;

  uint16_t tags_count;

  playerc_rfidtag_t *tags;
} playerc_rfid_t;

PLAYERC_EXPORT playerc_rfid_t *playerc_rfid_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_rfid_destroy(playerc_rfid_t *device);

PLAYERC_EXPORT int playerc_rfid_subscribe(playerc_rfid_t *device, int access);

PLAYERC_EXPORT int playerc_rfid_unsubscribe(playerc_rfid_t *device);

typedef player_pointcloud3d_element_t playerc_pointcloud3d_element_t;

typedef struct
{
  
  playerc_device_t info;

  uint16_t points_count;

  playerc_pointcloud3d_element_t *points;
} playerc_pointcloud3d_t;

PLAYERC_EXPORT playerc_pointcloud3d_t *playerc_pointcloud3d_create (playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_pointcloud3d_destroy (playerc_pointcloud3d_t *device);

PLAYERC_EXPORT int playerc_pointcloud3d_subscribe (playerc_pointcloud3d_t *device, int access);

PLAYERC_EXPORT int playerc_pointcloud3d_unsubscribe (playerc_pointcloud3d_t *device);

typedef player_pointcloud3d_stereo_element_t playerc_pointcloud3d_stereo_element_t;

typedef struct
{
  
  playerc_device_t info;

  playerc_camera_t left_channel;
  
  playerc_camera_t right_channel;

  playerc_camera_t disparity;

  uint32_t points_count;
  playerc_pointcloud3d_stereo_element_t *points;

} playerc_stereo_t;

PLAYERC_EXPORT playerc_stereo_t *playerc_stereo_create (playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_stereo_destroy (playerc_stereo_t *device);

PLAYERC_EXPORT int playerc_stereo_subscribe (playerc_stereo_t *device, int access);

PLAYERC_EXPORT int playerc_stereo_unsubscribe (playerc_stereo_t *device);

typedef struct
{
    
    playerc_device_t info;

    player_pose3d_t pose;
	player_pose3d_t vel;
	player_pose3d_t acc;

    player_imu_data_calib_t calib_data;

    float q0, q1, q2, q3;
} playerc_imu_t;

PLAYERC_EXPORT playerc_imu_t *playerc_imu_create (playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_imu_destroy (playerc_imu_t *device);

PLAYERC_EXPORT int playerc_imu_subscribe (playerc_imu_t *device, int access);

PLAYERC_EXPORT int playerc_imu_unsubscribe (playerc_imu_t *device);

PLAYERC_EXPORT int playerc_imu_datatype (playerc_imu_t *device, int value);

PLAYERC_EXPORT int playerc_imu_reset_orientation (playerc_imu_t *device, int value);

typedef struct
{
    
    playerc_device_t info;

    uint32_t node_type;
    
    uint32_t node_id;
    
    uint32_t node_parent_id;
    
    player_wsn_node_data_t data_packet;
} playerc_wsn_t;

PLAYERC_EXPORT playerc_wsn_t *playerc_wsn_create(playerc_client_t *client, int index);

PLAYERC_EXPORT void playerc_wsn_destroy(playerc_wsn_t *device);

PLAYERC_EXPORT int playerc_wsn_subscribe(playerc_wsn_t *device, int access);

PLAYERC_EXPORT int playerc_wsn_unsubscribe(playerc_wsn_t *device);

PLAYERC_EXPORT int playerc_wsn_set_devstate(playerc_wsn_t *device, int node_id,
                             int group_id, int devnr, int state);

PLAYERC_EXPORT int playerc_wsn_power(playerc_wsn_t *device, int node_id, int group_id,
                      int value);

PLAYERC_EXPORT int playerc_wsn_datatype(playerc_wsn_t *device, int value);

PLAYERC_EXPORT int playerc_wsn_datafreq(playerc_wsn_t *device, int node_id, int group_id,
                         double frequency);

#ifdef __cplusplus
}
#endif

#endif
