#ifndef _EXAMPLE_INTERFACE_H_XDR_
#define _EXAMPLE_INTERFACE_H_XDR_

#include <libplayerinterface/playerxdr.h>

#include "example_interface.h"

#ifdef __cplusplus
extern "C" {
#endif

int xdr_player_eginterf_data_t (XDR* xdrs, player_eginterf_data_t * msg);
PLAYERXDR_EXPORT int player_eginterf_data_pack(void* buf, size_t buflen, player_eginterf_data_t * msg, int op);
PLAYERXDR_EXPORT unsigned int player_eginterf_data_t_copy(player_eginterf_data_t *dest, const player_eginterf_data_t *src);
PLAYERXDR_EXPORT void player_eginterf_data_t_cleanup(const player_eginterf_data_t *msg);
PLAYERXDR_EXPORT player_eginterf_data_t * player_eginterf_data_t_clone(const player_eginterf_data_t *msg);
PLAYERXDR_EXPORT void player_eginterf_data_t_free(player_eginterf_data_t *msg);
PLAYERXDR_EXPORT unsigned int player_eginterf_data_t_sizeof(player_eginterf_data_t *msg);
int xdr_player_eginterf_req_t (XDR* xdrs, player_eginterf_req_t * msg);
PLAYERXDR_EXPORT int player_eginterf_req_pack(void* buf, size_t buflen, player_eginterf_req_t * msg, int op);
PLAYERXDR_EXPORT unsigned int player_eginterf_req_t_copy(player_eginterf_req_t *dest, const player_eginterf_req_t *src);
PLAYERXDR_EXPORT void player_eginterf_req_t_cleanup(const player_eginterf_req_t *msg);
PLAYERXDR_EXPORT player_eginterf_req_t * player_eginterf_req_t_clone(const player_eginterf_req_t *msg);
PLAYERXDR_EXPORT void player_eginterf_req_t_free(player_eginterf_req_t *msg);
PLAYERXDR_EXPORT unsigned int player_eginterf_req_t_sizeof(player_eginterf_req_t *msg);
int xdr_player_eginterf_cmd_t (XDR* xdrs, player_eginterf_cmd_t * msg);
PLAYERXDR_EXPORT int player_eginterf_cmd_pack(void* buf, size_t buflen, player_eginterf_cmd_t * msg, int op);
PLAYERXDR_EXPORT unsigned int player_eginterf_cmd_t_copy(player_eginterf_cmd_t *dest, const player_eginterf_cmd_t *src);
PLAYERXDR_EXPORT void player_eginterf_cmd_t_cleanup(const player_eginterf_cmd_t *msg);
PLAYERXDR_EXPORT player_eginterf_cmd_t * player_eginterf_cmd_t_clone(const player_eginterf_cmd_t *msg);
PLAYERXDR_EXPORT void player_eginterf_cmd_t_free(player_eginterf_cmd_t *msg);
PLAYERXDR_EXPORT unsigned int player_eginterf_cmd_t_sizeof(player_eginterf_cmd_t *msg);

#ifdef __cplusplus
}
#endif

#endif
