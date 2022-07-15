namespace DistanceService.Responses
{
    public class DistanceResponse
    {
        public double Distance { get; private set; }
        
        private DistanceResponse(double distance)
        {
            Distance = distance;
        }

        public static DistanceResponse EntityToDtoMapper(double distance)
            => new(distance);
    }
}
