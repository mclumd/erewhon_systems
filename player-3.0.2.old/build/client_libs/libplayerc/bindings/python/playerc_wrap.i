
typedef struct
{
    int *actual;

    %extend {
        int __getitem__(int index) {return $self->actual[index];}
        void __setitem__(int index,int value) {$self->actual[index]=value;}
    }
} intArray;

typedef struct
{
    double *actual;

    %extend {
        double __getitem__(int index) {return $self->actual[index];}
        void __setitem__(int index,double value) {$self->actual[index]=value;}
    }
} doubleArray;

typedef struct
{
    float *actual;

    %extend {
        float __getitem__(int index) {return $self->actual[index];}
        void __setitem__(int index,float value) {$self->actual[index]=value;}
    }
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

%header
%{
	typedef playerc_client_item_t playerc_client_item;
%}

typedef struct
{
  player_msghdr_t header;
  void *data;
	%extend
	{
	}
} playerc_client_item;

%header
%{
	#define new_playerc_mclient playerc_mclient_create
	#define del_playerc_mclient playerc_mclient_destroy
	typedef playerc_mclient_t playerc_mclient;
%}

typedef struct
{
  
  int client_count;
  struct _playerc_client_t *client[128];

  struct pollfd* pollfd;

  double time;

	%extend
	{
		playerc_mclient (void);
		void destroy(void);
		int addclient (struct _playerc_client_t *client);
		int peek (int timeout);
		int read (int timeout);
	}
} playerc_mclient;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT typedef void (*playerc_putmsg_fn_t) (void *device, char *header, char *data);

PLAYERC_EXPORT typedef void (*playerc_callback_fn_t) (void *data);

%header
%{
	typedef playerc_device_info_t playerc_device_info;
%}

typedef struct
{
  
  player_devaddr_t addr;

  char drivername[PLAYER_MAX_DRIVER_STRING_LEN];

	%extend
	{
	}
} playerc_device_info;

%header
%{
	#define new_playerc_client playerc_client_create
	#define del_playerc_client playerc_client_destroy
	typedef playerc_client_t playerc_client;
%}

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

  playerc_device_info devinfos[PLAYER_MAX_DEVICES];
  int devinfo_count;

  struct _playerc_device_t *device[PLAYER_MAX_DEVICES];
  int device_count;

  playerc_client_item qitems[PLAYERC_QUEUE_RING_SIZE];
  int qfirst, qlen, qsize;

  char *data;
  char *write_xdrdata;
  char *read_xdrdata;
  size_t read_xdrdata_len;

  double datatime;
  
  double lasttime;

  double request_timeout;

	%extend
	{
		playerc_client (playerc_mclient *mclient,
                                        const char *host, int port);
		void destroy(void);
		void set_transport (unsigned int transport);
		int connect (void);
		int disconnect (void);
		int disconnect_retry (void);
		int datamode (uint8_t mode);
		int requestdata (void);
		int set_replace_rule (int interf, int index, int type, int subtype, int replace);
		int adddevice (struct _playerc_device_t *device);
		int deldevice (struct _playerc_device_t *device);
		int addcallback (struct _playerc_device_t *device,
                                playerc_callback_fn_t callback, void *data);
		int delcallback (struct _playerc_device_t *device,
                                playerc_callback_fn_t callback, void *data);
		int get_devlist (void);
		int subscribe (int code, int index,
                             int access, char *drivername, size_t len);
		int unsubscribe (int code, int index);
		int request (struct _playerc_device_t *device, uint8_t reqtype,
                           const void *req_data, void **rep_data);
		int peek (int timeout);
		int internal_peek (int timeout);
		void * read (void);
		int read_nonblock (void);
		int read_nonblock_withproxy (void ** proxy);
		void set_request_timeout (uint32_t seconds);
		void set_retry_limit (int limit);
		void set_retry_time (double time);
		int write (struct _playerc_device_t *device,
                         uint8_t subtype,
                         void *cmd, double* timestamp);
	}
} playerc_client;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	typedef playerc_device_t playerc_device;
%}

typedef struct _playerc_device_t
{
  
  void *id;

  playerc_client *client;

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

	%extend
	{
		void init (playerc_client *client,
                         int code, int index, playerc_putmsg_fn_t putmsg);
		void term (void);
		int subscribe (int access);
		int unsubscribe (void);
		int hascapability (uint32_t type, uint32_t subtype);
		int get_boolprop (char *property, BOOL *value);
		int set_boolprop (char *property, BOOL value);
		int get_intprop (char *property, int32_t *value);
		int set_intprop (char *property, int32_t value);
		int get_dblprop (char *property, double *value);
		int set_dblprop (char *property, double value);
		int get_strprop (char *property, char **value);
		int set_strprop (char *property, char *value);
	}
} playerc_device;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_aio playerc_aio_create
	#define del_playerc_aio playerc_aio_destroy
	typedef playerc_aio_t playerc_aio;
%}

typedef struct
{
  
  playerc_device info;

  uint8_t voltages_count;

  floatArray voltages;

	%extend
	{
		playerc_aio (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_output (uint8_t id, float volt);
		float get_data (uint32_t index);
	}
} playerc_aio;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

#define PLAYERC_ACTARRAY_NUM_ACTUATORS PLAYER_ACTARRAY_NUM_ACTUATORS
#define PLAYERC_ACTARRAY_ACTSTATE_IDLE PLAYER_ACTARRAY_ACTSTATE_IDLE
#define PLAYERC_ACTARRAY_ACTSTATE_MOVING PLAYER_ACTARRAY_ACTSTATE_MOVING
#define PLAYERC_ACTARRAY_ACTSTATE_BRAKED PLAYER_ACTARRAY_ACTSTATE_BRAKED
#define PLAYERC_ACTARRAY_ACTSTATE_STALLED PLAYER_ACTARRAY_ACTSTATE_STALLED
#define PLAYERC_ACTARRAY_TYPE_LINEAR PLAYER_ACTARRAY_TYPE_LINEAR
#define PLAYERC_ACTARRAY_TYPE_ROTARY PLAYER_ACTARRAY_TYPE_ROTARY

%header
%{
	#define new_playerc_actarray playerc_actarray_create
	#define del_playerc_actarray playerc_actarray_destroy
	typedef playerc_actarray_t playerc_actarray;
%}

typedef struct
{
  
  playerc_device info;

  uint32_t actuators_count;
  
  player_actarray_actuator_t *actuators_data;
  
  uint32_t actuators_geom_count;
  player_actarray_actuatorgeom_t *actuators_geom;
  
  uint8_t motor_state;
  
  player_point_3d_t base_pos;
  
  player_orientation_3d_t base_orientation;
	%extend
	{
		playerc_actarray (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		player_actarray_actuator_t get_actuator_data (uint32_t index);
		player_actarray_actuatorgeom_t get_actuator_geom (uint32_t index);
		int get_geom (void);
		int position_cmd (int joint, float position);
		int multi_position_cmd (float *positions, int positions_count);
		int speed_cmd (int joint, float speed);
		int multi_speed_cmd (float *speeds, int speeds_count);
		int home_cmd (int joint);
		int current_cmd (int joint, float current);
		int multi_current_cmd (float *currents, int currents_count);
		int power (uint8_t enable);
		int brakes (uint8_t enable);
		int speed_config (int joint, float speed);
		int accel_config (int joint, float accel);
	}
} playerc_actarray;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_audio playerc_audio_create
	#define del_playerc_audio playerc_audio_destroy
	typedef playerc_audio_t playerc_audio;
%}

typedef struct
{
  
  playerc_device info;

  player_audio_mixer_channel_list_detail_t channel_details_list;

  player_audio_wav_t wav_data;

  player_audio_seq_t seq_data;

  player_audio_mixer_channel_list_t mixer_data;

  uint32_t state;

  int last_index;

	%extend
	{
		playerc_audio (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int wav_play_cmd (uint32_t data_count, uint8_t data[], uint32_t format);
		int wav_stream_rec_cmd (uint8_t state);
		int sample_play_cmd (int index);
		int seq_play_cmd (player_audio_seq_t * tones);
		int mixer_multchannels_cmd (player_audio_mixer_channel_list_t * levels);
		int mixer_channel_cmd (uint32_t index, float amplitude, uint8_t active);
		int wav_rec (void);
		int sample_load (int index, uint32_t data_count, uint8_t data[], uint32_t format);
		int sample_retrieve (int index);
		int sample_rec (int index, uint32_t length);
		int get_mixer_levels (void);
		int get_mixer_details (void);
	}
} playerc_audio;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

#define PLAYERC_BLACKBOARD_DATA_TYPE_NONE       0
#define PLAYERC_BLACKBOARD_DATA_TYPE_SIMPLE     1
#define PLAYERC_BLACKBOARD_DATA_TYPE_COMPLEX    2

#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_NONE    0
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_STRING  1
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_INT     2
#define PLAYERC_BLACKBOARD_DATA_SUBTYPE_DOUBLE  3

%header
%{
	#define new_playerc_blackboard playerc_blackboard_create
	#define del_playerc_blackboard playerc_blackboard_destroy
	typedef playerc_blackboard_t playerc_blackboard;
%}

typedef struct playerc_blackboard
{
  
  playerc_device info;
  
  void (*on_blackboard_event)(struct playerc_blackboard*, player_blackboard_entry_t);
  
  void *py_private;
	%extend
	{
		playerc_blackboard (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int subscribe_to_key (const char* key, const char* group, player_blackboard_entry_t** entry);
		int get_entry (const char* key, const char* group, player_blackboard_entry_t** entry);
		int unsubscribe_from_key (const char* key, const char* group);
		int subscribe_to_group (const char* group);
		int unsubscribe_from_group (const char* group);
		int set_entry (player_blackboard_entry_t* entry);
		int set_string (const char* key, const char* group, const char* value);
		int set_int (const char* key, const char* group, const int value);
		int set_double (const char* key, const char* group, const double value);
	}
} playerc_blackboard;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_blinkenlight playerc_blinkenlight_create
	#define del_playerc_blinkenlight playerc_blinkenlight_destroy
	typedef playerc_blinkenlight_t playerc_blinkenlight;
%}

typedef struct
{
  
  playerc_device info;

  uint32_t enabled;
  double duty_cycle;
  double period;
  uint8_t red, green, blue;
	%extend
	{
		playerc_blinkenlight (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int enable (uint32_t enable );
		int color (uint32_t id,
				uint8_t red,
				uint8_t green,
				uint8_t blue );
		int blink (uint32_t id,
				float period,
				float duty_cycle );
	}
} playerc_blinkenlight;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

typedef player_blobfinder_blob_t playerc_blobfinder_blob_t;

%header
%{
	#define new_playerc_blobfinder playerc_blobfinder_create
	#define del_playerc_blobfinder playerc_blobfinder_destroy
	typedef playerc_blobfinder_t playerc_blobfinder;
%}

typedef struct
{
  
  playerc_device info;

  unsigned int width, height;

  unsigned int blobs_count;
  playerc_blobfinder_blob_t *blobs;

	%extend
	{
		playerc_blobfinder (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_blobfinder;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_bumper playerc_bumper_create
	#define del_playerc_bumper playerc_bumper_destroy
	typedef playerc_bumper_t playerc_bumper;
%}

typedef struct
{
  
  playerc_device info;

  int pose_count;

  player_bumper_define_t *poses;

  int bumper_count;

  uint8_t *bumpers;

	%extend
	{
		playerc_bumper (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
	}
} playerc_bumper;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_camera playerc_camera_create
	#define del_playerc_camera playerc_camera_destroy
	typedef playerc_camera_t playerc_camera;
%}

typedef struct
{
  
  playerc_device info;

  int width, height;

  int bpp;

  int format;

  int fdiv;

  int compression;

  int image_count;

  uint8_t *image;

	%extend
	{
		playerc_camera (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		void decompress (void);
		void save (const char *filename);
	}
} playerc_camera;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_dio playerc_dio_create
	#define del_playerc_dio playerc_dio_destroy
	typedef playerc_dio_t playerc_dio;
%}

typedef struct
{
  
  playerc_device info;

    uint8_t count;

    uint32_t digin;

	%extend
	{
		playerc_dio (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_output (uint8_t output_count, uint32_t digout);
	}
} playerc_dio;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_fiducial playerc_fiducial_create
	#define del_playerc_fiducial playerc_fiducial_destroy
	typedef playerc_fiducial_t playerc_fiducial;
%}

typedef struct
{
  
  playerc_device info;

  player_fiducial_geom_t fiducial_geom;

  int fiducials_count;
  player_fiducial_item_t *fiducials;

	%extend
	{
		playerc_fiducial (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
	}
} playerc_fiducial;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_gps playerc_gps_create
	#define del_playerc_gps playerc_gps_destroy
	typedef playerc_gps_t playerc_gps;
%}

typedef struct
{
  
  playerc_device info;

  double utc_time;

  double lat, lon;

  double alt;

  double utm_e, utm_n;

  double hdop;

  double vdop;

  double err_horz, err_vert;

  int quality;

  int sat_count;

	%extend
	{
		playerc_gps (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_gps;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_graphics2d playerc_graphics2d_create
	#define del_playerc_graphics2d playerc_graphics2d_destroy
	typedef playerc_graphics2d_t playerc_graphics2d;
%}

typedef struct
{
  
  playerc_device info;

  player_color_t color;

	%extend
	{
		playerc_graphics2d (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int setcolor (player_color_t col );
		int draw_points (player_point_2d_t pts[],
           int count );
		int draw_polyline (player_point_2d_t pts[],
             int count );
		int draw_polygon (player_point_2d_t pts[],
            int count,
            int filled,
            player_color_t fill_color );
		int clear (void);
	}
} playerc_graphics2d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_graphics3d playerc_graphics3d_create
	#define del_playerc_graphics3d playerc_graphics3d_destroy
	typedef playerc_graphics3d_t playerc_graphics3d;
%}

typedef struct
{
  
  playerc_device info;

  player_color_t color;

	%extend
	{
		playerc_graphics3d (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int setcolor (player_color_t col );
		int draw (player_graphics3d_draw_mode_t mode,
           player_point_3d_t pts[],
           int count );
		int clear (void);
		int translate (double x, double y, double z );
		int rotate (double a, double x, double y, double z );
	}
} playerc_graphics3d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_gripper playerc_gripper_create
	#define del_playerc_gripper playerc_gripper_destroy
	typedef playerc_gripper_t playerc_gripper;
%}

typedef struct
{
  
  playerc_device info;

  player_pose3d_t pose;
  player_bbox3d_t outer_size;
  player_bbox3d_t inner_size;
  
  uint8_t num_beams;
  
  uint8_t capacity;

  uint8_t state;
  
  uint32_t beams;
  
  uint8_t stored;
	%extend
	{
		playerc_gripper (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int open_cmd (void);
		int close_cmd (void);
		int stop_cmd (void);
		int store_cmd (void);
		int retrieve_cmd (void);
		void printout (const char* prefix);
		int get_geom (void);
	}
} playerc_gripper;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_health playerc_health_create
	#define del_playerc_health playerc_health_destroy
	typedef playerc_health_t playerc_health;
%}

typedef struct
{
    
    playerc_device info;
    
    player_health_cpu_t cpu_usage;
    
    player_health_memory_t mem;
    
    player_health_memory_t swap;
	%extend
	{
		playerc_health (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_health;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_ir playerc_ir_create
	#define del_playerc_ir playerc_ir_destroy
	typedef playerc_ir_t playerc_ir;
%}

typedef struct
{
  
  playerc_device info;

  player_ir_data_t data;

  player_ir_pose_t poses;

	%extend
	{
		playerc_ir (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
	}
} playerc_ir;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_joystick playerc_joystick_create
	#define del_playerc_joystick playerc_joystick_destroy
	typedef playerc_joystick_t playerc_joystick;
%}

typedef struct
{
  
  playerc_device info;
  int32_t axes_count;
  int32_t pos[8];
  uint32_t buttons;
  intArray axes_max;
  intArray axes_min;
  doubleArray scale_pos;

	%extend
	{
		playerc_joystick (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_joystick;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_laser playerc_laser_create
	#define del_playerc_laser playerc_laser_destroy
	typedef playerc_laser_t playerc_laser;
%}

typedef struct
{
  
  playerc_device info;

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
	%extend
	{
		playerc_laser (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_config (double min_angle, double max_angle,
                             double resolution,
                             double range_res,
                             unsigned char intensity,
                             double scanning_frequency);
		int get_config (double *min_angle,
                             double *max_angle,
                             double *resolution,
                             double *range_res,
                             unsigned char *intensity,
                             double *scanning_frequency);
		int get_geom (void);
		int get_id (void);
		void printout (const char* prefix );
	}
} playerc_laser;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_limb playerc_limb_create
	#define del_playerc_limb playerc_limb_destroy
	typedef playerc_limb_t playerc_limb;
%}

typedef struct
{
  
  playerc_device info;

  player_limb_data_t data;
  player_limb_geom_req_t geom;
	%extend
	{
		playerc_limb (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
		int home_cmd (void);
		int stop_cmd (void);
		int setpose_cmd (float pX, float pY, float pZ, float aX, float aY, float aZ, float oX, float oY, float oZ);
		int setposition_cmd (float pX, float pY, float pZ);
		int vecmove_cmd (float x, float y, float z, float length);
		int power (uint32_t enable);
		int brakes (uint32_t enable);
		int speed_config (float speed);
	}
} playerc_limb;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	typedef playerc_localize_particle_t playerc_localize_particle;
%}

typedef struct playerc_localize_particle
{
  double pose[3];
  double weight;
	%extend
	{
	}
} playerc_localize_particle;

%header
%{
	#define new_playerc_localize playerc_localize_create
	#define del_playerc_localize playerc_localize_destroy
	typedef playerc_localize_t playerc_localize;
%}

typedef struct
{
  
  playerc_device info;

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
  playerc_localize_particle *particles;

	%extend
	{
		playerc_localize (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_pose (double pose[3], double cov[3]);
		int get_particles (void);
	}
} playerc_localize;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_log playerc_log_create
	#define del_playerc_log playerc_log_destroy
	typedef playerc_log_t playerc_log;
%}

typedef struct
{
  
  playerc_device info;

  int type;

  int state;
	%extend
	{
		playerc_log (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_write_state (int state);
		int set_read_state (int state);
		int set_read_rewind (void);
		int get_state (void);
		int set_filename (const char* fname);
	}
} playerc_log;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_map playerc_map_create
	#define del_playerc_map playerc_map_destroy
	typedef playerc_map_t playerc_map;
%}

typedef struct
{
  
  playerc_device info;

  double resolution;

  int width, height;

  double origin[2];

  char* cells;

  double vminx, vminy, vmaxx, vmaxy;
  int num_segments;
  player_segment_t* segments;
	%extend
	{
		playerc_map (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_map (void);
		int get_vector (void);
	}
} playerc_map;

#define PLAYERC_MAP_INDEX(dev, i, j) ((dev->width) * (j) + (i))

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_vectormap playerc_vectormap_create
	#define del_playerc_vectormap playerc_vectormap_destroy
	typedef playerc_vectormap_t playerc_vectormap;
%}

typedef struct
{
  
  playerc_device info;
  
  uint32_t srid;
  
  player_extent2d_t extent;
  
  uint32_t layers_count;
  
  player_vectormap_layer_data_t** layers_data;
  
  player_vectormap_layer_info_t** layers_info;
  
  playerwkbprocessor_t wkbprocessor;

	%extend
	{
		playerc_vectormap (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_map_info (void);
		int get_layer_data (unsigned layer_index);
		int write_layer (const player_vectormap_layer_data_t * data);
		void cleanup (void);
		uint8_t * get_feature_data (unsigned layer_index, unsigned feature_index);
		size_t get_feature_data_count (unsigned layer_index, unsigned feature_index);
	}
} playerc_vectormap;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT
PLAYERC_EXPORT

%header
%{
	#define new_playerc_opaque playerc_opaque_create
	#define del_playerc_opaque playerc_opaque_destroy
	typedef playerc_opaque_t playerc_opaque;
%}

typedef struct
{
  
  playerc_device info;

  int data_count;

  uint8_t *data;
	%extend
	{
		playerc_opaque (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int cmd (player_opaque_data_t *data);
		int req (player_opaque_data_t *request, player_opaque_data_t **reply);
	}
} playerc_opaque;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_planner playerc_planner_create
	#define del_playerc_planner playerc_planner_destroy
	typedef playerc_planner_t playerc_planner;
%}

typedef struct
{
  
  playerc_device info;

  int path_valid;

  int path_done;

  double px, py, pa;

  double gx, gy, ga;

  double wx, wy, wa;

  int curr_waypoint;

  int waypoint_count;

  double (*waypoints)[3];

	%extend
	{
		playerc_planner (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_cmd_pose (double gx, double gy, double ga);
		int get_waypoints (void);
		int enable (int state);
	}
} playerc_planner;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_position1d playerc_position1d_create
	#define del_playerc_position1d playerc_position1d_destroy
	typedef playerc_position1d_t playerc_position1d;
%}

typedef struct
{
  
  playerc_device info;

  double pose[3];
  double size[2];

  double pos;

  double vel;

  int stall;

  int status;

	%extend
	{
		playerc_position1d (playerc_client *client,
                                                int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int enable (int enable);
		int get_geom (void);
		int set_cmd_vel (double vel, int state);
		int set_cmd_pos (double pos, int state);
		int set_cmd_pos_with_vel (double pos, double vel, int state);
		int set_odom (double odom);
	}
} playerc_position1d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_position2d playerc_position2d_create
	#define del_playerc_position2d playerc_position2d_destroy
	typedef playerc_position2d_t playerc_position2d;
%}

typedef struct
{
  
  playerc_device info;

  double pose[3];
  double size[2];

  double px, py, pa;

  double vx, vy, va;

  int stall;

	%extend
	{
		playerc_position2d (playerc_client *client,
                                                int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int enable (int enable);
		int get_geom (void);
		int set_cmd_vel (double vx, double vy, double va, int state);
		int set_cmd_pose_with_vel (player_pose2d_t pos,
                                             player_pose2d_t vel,
                                             int state);
		int set_cmd_vel_head (double vx, double vy, double pa, int state);
		int set_cmd_pose (double gx, double gy, double ga, int state);
		int set_cmd_car (double vx, double a);
		int set_odom (double ox, double oy, double oa);
	}
} playerc_position2d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_position3d playerc_position3d_create
	#define del_playerc_position3d playerc_position3d_destroy
	typedef playerc_position3d_t playerc_position3d;
%}

typedef struct
{
  
  playerc_device info;

  double pose[3];
  double size[2];

  double pos_x, pos_y, pos_z;

  double pos_roll, pos_pitch, pos_yaw;

  double vel_x, vel_y, vel_z;

  double vel_roll, vel_pitch, vel_yaw;

  int stall;

	%extend
	{
		playerc_position3d (playerc_client *client,
                                                int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int enable (int enable);
		int get_geom (void);
		int set_velocity (double vx, double vy, double vz,
                                    double vr, double vp, double vt,
                                    int state);
		int set_speed (double vx, double vy, double vz, int state);
		int set_pose (double gx, double gy, double gz,
                                double gr, double gp, double gt);
		int set_pose_with_vel (player_pose3d_t pos,
                                         player_pose3d_t vel);
		int set_cmd_pose (double gx, double gy, double gz);
		int set_vel_mode (int mode);
		int set_odom (double ox, double oy, double oz,
                                double oroll, double opitch, double oyaw);
		int reset_odom (void);
	}
} playerc_position3d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_power playerc_power_create
	#define del_playerc_power playerc_power_destroy
	typedef playerc_power_t playerc_power;
%}

typedef struct
{
  
  playerc_device info;

  int valid;

  double charge;

  double percent;

  double joules;

  double watts;

  int charging;

	%extend
	{
		playerc_power (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_power;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_ptz playerc_ptz_create
	#define del_playerc_ptz playerc_ptz_destroy
	typedef playerc_ptz_t playerc_ptz;
%}

typedef struct
{
  
  playerc_device info;

  double pan, tilt;

  double zoom;

  int status;
	%extend
	{
		playerc_ptz (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set (double pan, double tilt, double zoom);
		int query_status (void);
		int set_ws (double pan, double tilt, double zoom,
                       double panspeed, double tiltspeed);
		int set_control_mode (int mode);
	}
} playerc_ptz;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_ranger playerc_ranger_create
	#define del_playerc_ranger playerc_ranger_destroy
	typedef playerc_ranger_t playerc_ranger;
%}

typedef struct
{
  
  playerc_device info;

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

	%extend
	{
		playerc_ranger (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
		int power_config (uint8_t value);
		int intns_config (uint8_t value);
		int set_config (double min_angle,
                              double max_angle, double angular_res,
                              double min_range, double max_range,
                              double range_res, double frequency);
		int get_config (double *min_angle,
                              double *max_angle, double *angular_res,
                              double *min_range, double *max_range,
                              double *range_res, double *frequency);
	}
} playerc_ranger;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_sonar playerc_sonar_create
	#define del_playerc_sonar playerc_sonar_destroy
	typedef playerc_sonar_t playerc_sonar;
%}

typedef struct
{
  
  playerc_device info;

  int pose_count;

  player_pose3d_t *poses;

  int scan_count;

  doubleArray scan;

	%extend
	{
		playerc_sonar (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int get_geom (void);
	}
} playerc_sonar;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	typedef playerc_wifi_link_t playerc_wifi_link;
%}

typedef struct
{
  
  uint8_t mac[32];

  uint8_t ip[32];

  uint8_t essid[32];

  int mode;

  int encrypt;

  double freq;

  int qual, level, noise;

	%extend
	{
	}
} playerc_wifi_link;

%header
%{
	#define new_playerc_wifi playerc_wifi_create
	#define del_playerc_wifi playerc_wifi_destroy
	typedef playerc_wifi_t playerc_wifi;
%}

typedef struct
{
  
  playerc_device info;

  playerc_wifi_link *links;
  int link_count;
  char ip[32];
	%extend
	{
		playerc_wifi (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		playerc_wifi_link * get_link (int link);
	}
} playerc_wifi;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_simulation playerc_simulation_create
	#define del_playerc_simulation playerc_simulation_destroy
	typedef playerc_simulation_t playerc_simulation;
%}

typedef struct
{
  
  playerc_device info;

	%extend
	{
		playerc_simulation (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_pose2d (char* name,
                                  double gx, double gy, double ga);
		int get_pose2d (char* identifier,
				  double *x, double *y, double *a);
		int set_pose3d (char* name,
				  double gx, double gy, double gz,
				  double groll, double gpitch, double gyaw);
		int get_pose3d (char* identifier,
				  double *x, double *y, double *z,
				  double *roll, double *pitch, double *yaw, double *time);
		int set_property (char* name,
                                    char* property,
                                    void* value,
				    size_t value_len);
		int get_property (char* name,
                                    char* property,
                                    void* value,
                                    size_t value_len);
		int pause (void);
		int reset (void);
		int save (void);
	}
} playerc_simulation;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_speech playerc_speech_create
	#define del_playerc_speech playerc_speech_destroy
	typedef playerc_speech_t playerc_speech;
%}

typedef struct
{
  
  playerc_device info;
	%extend
	{
		playerc_speech (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int say (char *);
	}
} playerc_speech;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_speechrecognition playerc_speechrecognition_create
	#define del_playerc_speechrecognition playerc_speechrecognition_destroy
	typedef playerc_speechrecognition_t playerc_speechrecognition;
%}

typedef struct
{
  
  playerc_device info;

  char *rawText;
  
  char **words;
  int wordCount;
	%extend
	{
		playerc_speechrecognition (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_speechrecognition;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	typedef playerc_rfidtag_t playerc_rfidtag;
%}

typedef struct
{
    
    uint32_t type;
    
    uint32_t guid_count;
    
    uint8_t *guid;
	%extend
	{
	}
}  playerc_rfidtag;

%header
%{
	#define new_playerc_rfid playerc_rfid_create
	#define del_playerc_rfid playerc_rfid_destroy
	typedef playerc_rfid_t playerc_rfid;
%}

typedef struct
{
  
  playerc_device info;

  uint16_t tags_count;

  playerc_rfidtag *tags;
	%extend
	{
		playerc_rfid (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_rfid;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

typedef player_pointcloud3d_element_t playerc_pointcloud3d_element_t;

%header
%{
	#define new_playerc_pointcloud3d playerc_pointcloud3d_create
	#define del_playerc_pointcloud3d playerc_pointcloud3d_destroy
	typedef playerc_pointcloud3d_t playerc_pointcloud3d;
%}

typedef struct
{
  
  playerc_device info;

  uint16_t points_count;

  playerc_pointcloud3d_element_t *points;
	%extend
	{
		playerc_pointcloud3d (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_pointcloud3d;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

typedef player_pointcloud3d_stereo_element_t playerc_pointcloud3d_stereo_element_t;

%header
%{
	#define new_playerc_stereo playerc_stereo_create
	#define del_playerc_stereo playerc_stereo_destroy
	typedef playerc_stereo_t playerc_stereo;
%}

typedef struct
{
  
  playerc_device info;

  playerc_camera left_channel;
  
  playerc_camera right_channel;

  playerc_camera disparity;

  uint32_t points_count;
  playerc_pointcloud3d_stereo_element_t *points;

	%extend
	{
		playerc_stereo (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
	}
} playerc_stereo;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_imu playerc_imu_create
	#define del_playerc_imu playerc_imu_destroy
	typedef playerc_imu_t playerc_imu;
%}

typedef struct
{
    
    playerc_device info;

    player_pose3d_t pose;
	player_pose3d_t vel;
	player_pose3d_t acc;

    player_imu_data_calib_t calib_data;

    float q0, q1, q2, q3;
	%extend
	{
		playerc_imu (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int datatype (int value);
		int reset_orientation (int value);
	}
} playerc_imu;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

%header
%{
	#define new_playerc_wsn playerc_wsn_create
	#define del_playerc_wsn playerc_wsn_destroy
	typedef playerc_wsn_t playerc_wsn;
%}

typedef struct
{
    
    playerc_device info;

    uint32_t node_type;
    
    uint32_t node_id;
    
    uint32_t node_parent_id;
    
    player_wsn_node_data_t data_packet;
	%extend
	{
		playerc_wsn (playerc_client *client, int index);
		void destroy(void);
		int subscribe (int access);
		int unsubscribe (void);
		int set_devstate (int node_id,
                             int group_id, int devnr, int state);
		int power (int node_id, int group_id,
                      int value);
		int datatype (int value);
		int datafreq (int node_id, int group_id,
                         double frequency);
	}
} playerc_wsn;

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

PLAYERC_EXPORT

#ifdef __cplusplus
}
#endif

#endif
