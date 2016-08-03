// This file was automatically generated by the Player build system.
// Any changes made to it will be overwritten.

#include <libplayercore/playercore.h>

#if defined (WIN32)
#if defined (PLAYER_STATIC)
#define PLAYERDRIVER_EXPORT
#elif defined (playerdrivers_EXPORTS)
#define PLAYERDRIVER_EXPORT __declspec (dllexport)
#else
#define PLAYERDRIVER_EXPORT __declspec (dllimport)
#endif
#else
#define PLAYERDRIVER_EXPORT
#endif

void alsa_Register(DriverTable *table);
void localbb_Register(DriverTable *table);
void acts_Register(DriverTable *table);
void cmvision_Register(DriverTable *table);
void searchpattern_Register(DriverTable *table);
void camerav4l_Register(DriverTable *table);
void camerav4l2_Register(DriverTable *table);
void camfilter_Register(DriverTable *table);
void cameracompress_Register(DriverTable *table);
void camerauncompress_Register(DriverTable *table);
void imgcmp_Register(DriverTable *table);
void imgsave_Register(DriverTable *table);
void sphere_Register(DriverTable *table);
void camerauvc_Register(DriverTable *table);
void bitlogic_Register(DriverTable *table);
void blobtodio_Register(DriverTable *table);
void blobtracker_Register(DriverTable *table);
void bumpertodio_Register(DriverTable *table);
void diodelay_Register(DriverTable *table);
void diolatch_Register(DriverTable *table);
void portio_Register(DriverTable *table);
void rangertodio_Register(DriverTable *table);
void serio_Register(DriverTable *table);
void stalltodio_Register(DriverTable *table);
void laserbar_Register(DriverTable *table);
void laserbarcode_Register(DriverTable *table);
void laservisualbarcode_Register(DriverTable *table);
void laservisualbw_Register(DriverTable *table);
void garminnmea_Register(DriverTable *table);
void rt3xxx_Register(DriverTable *table);
void xsensmt_Register(DriverTable *table);
void nimu_Register(DriverTable *table);
void linuxjoystick_Register(DriverTable *table);
void bumper2laser_Register(DriverTable *table);
void pbslaser_Register(DriverTable *table);
void sicklms200_Register(DriverTable *table);
void sicklms400_Register(DriverTable *table);
void sicks3000_Register(DriverTable *table);
void laserposeinterpolator_Register(DriverTable *table);
void lasercspace_Register(DriverTable *table);
void laserrescan_Register(DriverTable *table);
void lasercutter_Register(DriverTable *table);
void rs4leuze_Register(DriverTable *table);
void sickLDMRS_Register(DriverTable *table);
void amcl_Register(DriverTable *table);
void fakelocalize_Register(DriverTable *table);
void mapfile_Register(DriverTable *table);
void mapcspace_Register(DriverTable *table);
void mapscale_Register(DriverTable *table);
void vmapfile_Register(DriverTable *table);
void gridmap_Register(DriverTable *table);
void obot_Register(DriverTable *table);
void clodbuster_Register(DriverTable *table);
void cmucam2_Register(DriverTable *table);
void epuck_Register(DriverTable *table);
void erratic_Register(DriverTable *table);
void er1_Register(DriverTable *table);
void create_Register(DriverTable *table);
void roomba_Register(DriverTable *table);
void khepera_Register(DriverTable *table);
void mricp_Register(DriverTable *table);
void nomad_Register(DriverTable *table);
void p2os_Register(DriverTable *table);
void reb_Register(DriverTable *table);
void rflex_Register(DriverTable *table);
void wbr914_Register(DriverTable *table);
void serialstream_Register(DriverTable *table);
void tcpstream_Register(DriverTable *table);
void wavefront_Register(DriverTable *table);
void laserptzcloud_Register(DriverTable *table);
void flockofbirds_Register(DriverTable *table);
void blobposition_Register(DriverTable *table);
void bumpersafe_Register(DriverTable *table);
void deadstop_Register(DriverTable *table);
void globalize_Register(DriverTable *table);
void goto_Register(DriverTable *table);
void lasersafe_Register(DriverTable *table);
void mbicp_Register(DriverTable *table);
void microstrain_Register(DriverTable *table);
void motionmind_Register(DriverTable *table);
void sicknav200_Register(DriverTable *table);
void nd_Register(DriverTable *table);
void segwayrmp400_Register(DriverTable *table);
void snd_Register(DriverTable *table);
void roboteq_Register(DriverTable *table);
void vfh_Register(DriverTable *table);
void amtecpowercube_Register(DriverTable *table);
void canonvcc4_Register(DriverTable *table);
void ptu46_Register(DriverTable *table);
void sonyevid30_Register(DriverTable *table);
void sphereptz_Register(DriverTable *table);
void lasertoranger_Register(DriverTable *table);
void sonartoranger_Register(DriverTable *table);
void rangertolaser_Register(DriverTable *table);
void rangerposeinterpolator_Register(DriverTable *table);
void insideM300_Register(DriverTable *table);
void sickRFI341_Register(DriverTable *table);
void skyetekM1_Register(DriverTable *table);
void acr120u_Register(DriverTable *table);
void cmdsplitter_Register(DriverTable *table);
void diocmd_Register(DriverTable *table);
void dummy_Register(DriverTable *table);
void gripcmd_Register(DriverTable *table);
void inhibitor_Register(DriverTable *table);
void kartowriter_Register(DriverTable *table);
void writelog_Register(DriverTable *table);
void readlog_Register(DriverTable *table);
void passthrough_Register(DriverTable *table);
void relay_Register(DriverTable *table);
void suppressor_Register(DriverTable *table);
void velcmd_Register(DriverTable *table);
void opaquecmd_Register(DriverTable *table);
void speechcmd_Register(DriverTable *table);
void AioToSonar_Register(DriverTable *table);
void festival_Register(DriverTable *table);
void vec2map_Register(DriverTable *table);
void robotracker_Register(DriverTable *table);
void aodv_Register(DriverTable *table);
void iwspy_Register(DriverTable *table);
void linuxwifi_Register(DriverTable *table);
void mica2_Register(DriverTable *table);
void accel_calib_Register(DriverTable *table);

PLAYERDRIVER_EXPORT void player_register_drivers()
{
  alsa_Register(driverTable);
  localbb_Register(driverTable);
  acts_Register(driverTable);
  cmvision_Register(driverTable);
  searchpattern_Register(driverTable);
  camerav4l_Register(driverTable);
  camerav4l2_Register(driverTable);
  camfilter_Register(driverTable);
  cameracompress_Register(driverTable);
  camerauncompress_Register(driverTable);
  imgcmp_Register(driverTable);
  imgsave_Register(driverTable);
  sphere_Register(driverTable);
  camerauvc_Register(driverTable);
  bitlogic_Register(driverTable);
  blobtodio_Register(driverTable);
  blobtracker_Register(driverTable);
  bumpertodio_Register(driverTable);
  diodelay_Register(driverTable);
  diolatch_Register(driverTable);
  portio_Register(driverTable);
  rangertodio_Register(driverTable);
  serio_Register(driverTable);
  stalltodio_Register(driverTable);
  laserbar_Register(driverTable);
  laserbarcode_Register(driverTable);
  laservisualbarcode_Register(driverTable);
  laservisualbw_Register(driverTable);
  garminnmea_Register(driverTable);
  rt3xxx_Register(driverTable);
  xsensmt_Register(driverTable);
  nimu_Register(driverTable);
  linuxjoystick_Register(driverTable);
  bumper2laser_Register(driverTable);
  pbslaser_Register(driverTable);
  sicklms200_Register(driverTable);
  sicklms400_Register(driverTable);
  sicks3000_Register(driverTable);
  laserposeinterpolator_Register(driverTable);
  lasercspace_Register(driverTable);
  laserrescan_Register(driverTable);
  lasercutter_Register(driverTable);
  rs4leuze_Register(driverTable);
  sickLDMRS_Register(driverTable);
  amcl_Register(driverTable);
  fakelocalize_Register(driverTable);
  mapfile_Register(driverTable);
  mapcspace_Register(driverTable);
  mapscale_Register(driverTable);
  vmapfile_Register(driverTable);
  gridmap_Register(driverTable);
  obot_Register(driverTable);
  clodbuster_Register(driverTable);
  cmucam2_Register(driverTable);
  epuck_Register(driverTable);
  erratic_Register(driverTable);
  er1_Register(driverTable);
  create_Register(driverTable);
  roomba_Register(driverTable);
  khepera_Register(driverTable);
  mricp_Register(driverTable);
  nomad_Register(driverTable);
  p2os_Register(driverTable);
  reb_Register(driverTable);
  rflex_Register(driverTable);
  wbr914_Register(driverTable);
  serialstream_Register(driverTable);
  tcpstream_Register(driverTable);
  wavefront_Register(driverTable);
  laserptzcloud_Register(driverTable);
  flockofbirds_Register(driverTable);
  blobposition_Register(driverTable);
  bumpersafe_Register(driverTable);
  deadstop_Register(driverTable);
  globalize_Register(driverTable);
  goto_Register(driverTable);
  lasersafe_Register(driverTable);
  mbicp_Register(driverTable);
  microstrain_Register(driverTable);
  motionmind_Register(driverTable);
  sicknav200_Register(driverTable);
  nd_Register(driverTable);
  segwayrmp400_Register(driverTable);
  snd_Register(driverTable);
  roboteq_Register(driverTable);
  vfh_Register(driverTable);
  amtecpowercube_Register(driverTable);
  canonvcc4_Register(driverTable);
  ptu46_Register(driverTable);
  sonyevid30_Register(driverTable);
  sphereptz_Register(driverTable);
  lasertoranger_Register(driverTable);
  sonartoranger_Register(driverTable);
  rangertolaser_Register(driverTable);
  rangerposeinterpolator_Register(driverTable);
  insideM300_Register(driverTable);
  sickRFI341_Register(driverTable);
  skyetekM1_Register(driverTable);
  acr120u_Register(driverTable);
  cmdsplitter_Register(driverTable);
  diocmd_Register(driverTable);
  dummy_Register(driverTable);
  gripcmd_Register(driverTable);
  inhibitor_Register(driverTable);
  kartowriter_Register(driverTable);
  writelog_Register(driverTable);
  readlog_Register(driverTable);
  passthrough_Register(driverTable);
  relay_Register(driverTable);
  suppressor_Register(driverTable);
  velcmd_Register(driverTable);
  opaquecmd_Register(driverTable);
  speechcmd_Register(driverTable);
  AioToSonar_Register(driverTable);
  festival_Register(driverTable);
  vec2map_Register(driverTable);
  robotracker_Register(driverTable);
  aodv_Register(driverTable);
  iwspy_Register(driverTable);
  linuxwifi_Register(driverTable);
  mica2_Register(driverTable);
  accel_calib_Register(driverTable);
}
